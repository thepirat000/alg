(* The main program. *)

open Config
open Output

module IntMap = Util.IntMap ;;

(* A big wrapper for error reporting. *)
  try begin

    (* References that store the command-line options *)
    let config = Config.default in

    (* Command-line options and usage *)
    let usage = "Usage: alg --size <n> <theory.th>" in

    let options = Arg.align [
      ("--help",
       Arg.Unit (fun () -> print_endline usage; exit 0),
       " Print this jelp");
      ("--size",
       Arg.String (fun str -> config.sizes <- List.sort compare (Util.union config.sizes (Util.sizes_of_str str))),
       " Comma-separated list of sizes and size intervals m-n that should be considered.");
      ("--count",
       Arg.Unit (fun () -> config.count_only <- true),
       " Just count the models, do not print them out.");
      ("--indecomposable",
       Arg.Unit (fun () -> config.indecomposable_only <- true),
       " Output only indecomposable models.");
      ("--no-products",
       Arg.Unit (fun () -> config.products <- false),
       " Do not try to generate algebras as products of smaller algebras.");
    ]
    in

    (* First we process the command line. *)

    (* Parse the arguments. Treat the anonymous arguments as files to be read. *)
    Arg.parse options
      (fun str ->
        match config.input_filename with
          | "" -> config.input_filename <- str
          | _ -> raise (Arg.Bad " only one theory file should be given"))
      usage ;

    (* Read the input file. *)
    let fh =
      begin match config.input_filename with
        | "" -> Error.fatal "please provide a theory file on the command line"
        | f -> open_in f
      end
    in

    let lex = Lexing.from_channel fh in

    let theory_name, raw_theory =
      begin
        try
          Parser.theory Lexer.token lex
        with
          | Parser.Error ->
            Error.syntax ~pos:(Lexing.lexeme_start_p lex, Lexing.lexeme_end_p lex) ""
          | Failure "lexing: empty token" ->
            Error.syntax ~pos:(Lexing.lexeme_start_p lex, Lexing.lexeme_end_p lex) "Unrecognised symbol."
      end
    in

    close_in fh ;

    (* Compute the theory name from the file name, if needed. *)
    let theory_name =
      begin match theory_name with
        | Some n -> n
        | None ->
          begin
            let n = Filename.basename config.input_filename in
            try String.sub n 0 (String.index n '.') with Not_found -> n
          end
      end in

    (* Parse the theory. *)
    let theory = Cook.cook_theory theory_name raw_theory in

    (* If --indecomposable is given then --no-products makes no sense. *)
    if config.indecomposable_only then config.products <- true ;

    (* Cache storing indecomposable algebras computed so far. *)
    let indecomposable_algebras = ref IntMap.empty in

    let lookup_cached n =
      try
        Some (IntMap.find n !indecomposable_algebras)
      with Not_found -> None
    in

    (* Processing of algebras of a given size and pass them to the given continuations,
       together with information whether the algebra is indecomposable. *)
    let rec process_size n output =
      (* Generate decomposable algebras if needed. *)
      let decomposables = 
        if n < Array.length theory.Type.th_const || not config.products then []
        else
          (* Generate indecomposable factors and then decomposable algebras from them. *)
          let factors =
            List.fold_left
              (fun m k ->
                 let lst =
                   begin match lookup_cached k with
                     | Some lst -> lst
                     | None ->
                         let lst = ref [] in
                           process_size k (fun (algebra, indecomposable) -> if indecomposable then lst := algebra :: !lst) ;
                           !lst
                   end
                 in
                   IntMap.add k lst m)
              IntMap.empty
              (Util.divisors n)
          in
            begin
              (* make decomposables *)
              Indecomposable.gen_decomposable theory n factors (fun a -> output (a, false))
            end
      in
      (* Generate indecomposable algebras. *)
      (* Are we going to cache these? *)
      let must_cache = config.products && List.exists (fun m -> n > 0 && m > n && m mod n = 0) config.sizes in
      let algebras = ref decomposables in
      let to_cache = ref [] in
        Enum.enum n theory
          (fun a -> 
             if First_order.check_axioms theory a && not (Iso.seen theory a !algebras) then
               begin
                 algebras := Util.copy_algebra a :: !algebras ;
                 if must_cache then to_cache := a :: !to_cache ;
                 output (a, true)
               end) ;
        if must_cache then indecomposable_algebras := IntMap.add n !to_cache !indecomposable_algebras
    in

    let out = Output.Text.init config stdout theory in

    (* The main loop *)
    begin
      out.header () ;
      List.iter
        (fun n -> 
           if not config.count_only then out.size_header n ;
           let k = ref 0 in
           let output (algebra, indecomposable) =
             incr k ;
             if not config.count_only && (not config.indecomposable_only || indecomposable)
             then out.algebra !k algebra
           in
             process_size n output ;
             if config.count_only
             then out.size_count n !k
             else out.size_footer n !k)
        config.sizes ;
      out.footer ()
    end
  end
  with Error.Error (pos, err, msg) -> Error.report (pos, err, msg)
