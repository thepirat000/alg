```math
\documentclass{article}

\usepackage{fullpage}
\usepackage{url}
\usepackage{listings}

\lstnewenvironment{shell}{\lstset{%
moredelim=*[is][\itshape]{/@}{@/},
numbers=none,xleftmargin=2em,basicstyle=\ttfamily\small}}{}

\lstnewenvironment{source}{\lstset{%
moredelim=*[is][\itshape]{/@}{@/},
numbers=none,mathescape=true,
xleftmargin=2em,basicstyle=\ttfamily\small}}{}

\begin{document}
\title{Alg User Manual}
\author{Ale\v{s} Bizjak\thanks{\texttt{Ales.Bizjak0@gmail.com},
  Faculty of Mathematics and Physics, University of Ljubljana}
  \and Andrej Bauer\thanks{\texttt{Andrej.Bauer@andrej.com},
    Faculty of Mathematics and Physics, University of Ljubljana}}

\maketitle

\tableofcontents

\section{Introduction}
\label{sec:introduction}

Alg is a program for enumeration of finite models of single-sorted
first-order theories. Such a theory is given by a signature (a list of
constants, operations and relations) and axioms expressed in
first-order logic. Examples of first-order theories include groups,
lattices, rings, fields, posets, graphs, and many others. Alg can do
the following:
%
\begin{itemize}
\item list or count all non-isomorphic models of a given theory,
\item list or count all non-isomorphic indecomposable\footnote{A model
  is indecomposable if it cannot be written as a non-trivial product
  of two smaller models.} models of a given theory.
\end{itemize}
%
Currently alg has the following limitations:
%
\begin{itemize}
\item the theory must be single-sorted,
\item only unary and binary operations are accepted,
\item only (unary) predicates and binary relations are accepted,
\item it is assumed that constants denote pairwise distinct elements.
\end{itemize}
%
This manual describes how to install and use alg. For a quick start
you need Ocaml 3.11 or newer and the menhir parser generator. Compile
alg with
%
\begin{shell}
make
\end{shell}
%
and run
%
\begin{shell}
./src/alg.native --size 8 theories/unital_commutative_ring.th
\end{shell}
%
For usage information type \texttt{./alg.native -help} and for
examples of theories see the \texttt{theories} subdirectory.

Alg is released under the open source simplified BSD License, as
detailed in the next section.

\section{Copyright and License}
\label{sec:copyr-license}

\noindent
Copyright {\copyright} 2010, Ale\v{s} Bizjak and Andrej Bauer

\bigskip

\noindent
All rights reserved.

\bigskip

\noindent
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:
%
\begin{itemize}
\item Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
\item Redistributions in binary form must reproduce the above
  copyright notice, this list of conditions and the following
  disclaimer in the documentation and/or other materials provided with
  the distribution.
\end{itemize}

This software is provided by the copyright holders and contributors
``as is'' and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.

\section{Installation}
\label{sec:installation}

\subsection{Downloading alg}
\label{sec:how-obtain-alg}

Alg is available at \url{http://hg.andrej.com/alg/}. You have three
options:
%
\begin{enumerate}
\item download the ZIP file with source code from
  \begin{quote}
    \url{http://hg.andrej.com/alg/archive/tip.zip}
  \end{quote}
\item clone the repository with the Mercurial revision control system:
%
\begin{shell}
hg clone http://hg.andrej.com/alg/
\end{shell}
\item download a precompiled executable for your architecture, as
  described at
  %
  \begin{quote}
    \url{http://math.andrej.com/alg/}
  \end{quote}
  %
  if one is available.
\end{enumerate}

\subsection{Installation for Linux and MacOS}
\label{sec:comp-under-linux}

\subsubsection{Prerequisites}

To compile alg you need Ocaml 3.11 or newer. It is also highly
desirable that you have the menhir parser generator and the Make
utility. See sections~\ref{sec:nomake} and~\ref{sec:nomenhir} on how
to compile without these.

You can get Ocaml and menhir in several ways:
%
\begin{enumerate}
\item On Ubuntu, install the packages \texttt{ocaml} and
  \texttt{menhir}:
  %
\begin{shell}
sudo apt-get install ocaml menhir    
\end{shell}
  Similar solutions are available on other Linux distributions.
\item On MacOS the easiest way to install Ocaml and menhir is with
  the macports utility:
\begin{shell}
sudo port install ocaml
sudo port install caml-menhir
\end{shell}
\item If you have GODI installed then you already have Ocaml. Install
  menhir with the \texttt{godi\_console} command, if you do not have it yet.
\item Ocaml is also available from
  %
  \begin{quote}
    \url{http://caml.inria.fr/}
  \end{quote}
  %
  and menhir from
  %
  \begin{quote}
    \url{http://pauillac.inria.fr/~fpottier/menhir/}
  \end{quote}
\end{enumerate}

\subsubsection{Compilation and installation}

To compile alg, type \texttt{make native} at the command line. If all goes well
ocamlbuild will generate a subdirectory \texttt{src/\_build} and in it the
\texttt{alg.native} executable. It will also create a link to
\texttt{src/\_build/alg.native} from the \texttt{src} directory. To test alg type
%
\begin{shell}
./src/alg.native --count --size 8 theories/group.th
\end{shell}
%
It should tell you within seconds that there are 5 groups of size 8. 

We provided only a very rudimentary installation procedure for alg.
First edit the \texttt{INSTALL\_DIR} setting in \texttt{src/Makefile} to
set the directory in which alg should be installed, then run
%
\begin{shell}
sudo make install
\end{shell}
%
This will simply copy \texttt{\_build/alg.native} to
\texttt{\$(INSTALL\_DIR)/alg}. You may also wish to stash the
\texttt{theories} subdirectory somewhere for future reference.

\subsubsection{Compiling the manual}
\label{sec:compiling-manual}

You do not have to compile the manual because it is included in
\texttt{doc/manual.pdf}. Nevertheless, you can recompile it by typing
\texttt{make doc} or directly by {\LaTeX}-ing \texttt{doc/manual.tex}.

\subsubsection{Compiling to bytecode}

If your version of Ocaml does not compile to native code you can try
compiling to bytecode with
%
\begin{shell}
make byte
\end{shell}
%
This will generate a (significantly slower) \texttt{src/alg.byte} executable.

\subsubsection{Installation without menhir}
\label{sec:nomenhir}

If you do not have menhir you can try the following trick:
%
\begin{itemize}
\item move the files \texttt{src/lexer.mll} and \texttt{src/parser.mly} out of
  the way into some other folder,
\item copy the files \texttt{src/nomenhir/lexer.ml} and
  \texttt{src/nomenhir/parser.ml} to where \texttt{src/lexer.mll} and
  \texttt{src/parser.mly} used to be,
\item compile with \texttt{make}.
\end{itemize}
%
In other words:
%
\begin{shell}
$ cd src
$ mv lexer.mll parser.mly nomenhir
$ cp nomenhir/lexer.ml nomenhir/parserl.ml .
$ make
\end{shell}
% $ to stop Emacs from misccoloring the rest of the text.

\subsubsection{Installation without Make}
\label{sec:nomake}

If you do not have the Make utility (how can that be?) you can compile
alg directly with ocamlbuild:
%
\begin{shell}
cd src
ocamlbuild -use-menhir alg.native
\end{shell}
%
To install alg just copy \texttt{src/\_build/alg.native} to
\texttt{/usr/local/bin/alg} or some other reasonable place.

\subsection{Installation for Microsoft Windows}
\label{sec:comp-inst-micr}

With Ocaml 3.11, menhir and the MinGW or cygwin suite installed
compilation should be essentially the same as for Linux and MacOS, as
described in section~\ref{sec:comp-under-linux}. Also see
sections~\ref{sec:nomenhir} and~\ref{sec:nomake} on how to compile
without menhir and Make.

Note that a Windows precompiled executable may be available at
\url{http://math.andrej.com/alg}.

\section{Input}
\label{sec:input}

An alg input file has extension \texttt{.th} and it describes an a
first-order theory. The syntax vaguely follows the syntax of the Coq
proof assistant. A typical input file might look like this:
%
\begin{source}
Theory Group.
Constant 1.
Unary inv.
Binary *.
Axiom unit_left: 1 * x = x.
Axiom unit_right: x * 1 = x.
Axiom inverse_left: x * inv(x) = 1.
Axiom inverse_right: inv(x) * x = 1.
Axiom associativity: (x * y) * z = x * (y * z).
\end{source}
%
The file starts with an optional \texttt{Theory} declaration which
names the theory, then we have declarations of constants, unary and
binary operations, predicates and binary relations (none in the above
example), and after that there are the axioms. The precise syntax
rules are as follows.

\subsection{Comments}

Comments are written as in Python, i.e., a comment begins with the
\texttt{\#} symbol and includes everything up to the end of line.

\subsection{General syntactic rules}

An alg input file consists of a sequence of declarations
(\texttt{Theory}, \texttt{Constant}, \texttt{Unary}, \texttt{Binary},
\texttt{Predicate}, \texttt{Relation}) and axioms (\texttt{Axiom},
\texttt{Theorem}). Each declaration and axiom is terminated with a
period.

\subsection{The \texttt{Theory} keyword}

You may give a name to your theory with the declaration
%
\begin{source}
Theory /@theory_name@/.
\end{source}
%
\emph{at the beginning of the input file}, possibly preceded by
comments and whitespace. The theory name consists of letters, numbers,
and the underscore. If you do not provide a theory name, alg will
deduce one from the file name.

\subsection{Declaration of operations and relations}

The declarations
%
\begin{source}
Constant /@$c_1$ $c_2$ $\ldots$ $c_k$@/.
Unary /@$u_1$ $u_2$ $\ldots$ $u_m$@/.
Binary /@$b_1$ $b_2$ $\ldots$ $b_n$@/.
Predicate /@$p_1$ $p_2$ $\ldots$ $p_l$@/.
Relation /@$r_1$ $r_2$ $\ldots$ $r_j$@/.
\end{source}
%
are used to declare constants, unary and binary operations,
predicates, and binary relations, respectively. You may declare
several constants or operations with a single declaration, or one at a
time. You may mix declarations and axioms, although it is probably a
good idea to declare the constants and operations first.

The keywords \texttt{Constants}, \texttt{Predicates} and
\texttt{Relations} are synonyms for their singular counterparts.

A constant may be any string of letters, digits and the underscore
character. In particular, a constant may consist just of digits, for
example \texttt{0} or \texttt{1}.

Predicates, relations, unary and binary operations may be strings of
letters, digits and the underscore character. For example, if we
declare
%
\begin{source}
Unary inv.
Binary mult.
\end{source}
%
then we can write expressions like \texttt{mult(x, inv(y))}. It is
even possible to declare operations whose names are strings of digits,
for example:
%
\begin{source}
Unary 3 ten.
Binary +.
Axiom: 3(3(x)) + x = ten(x).
\end{source}
%
Alternatively, we can use \emph{infix} and \emph{prefix} operators.
These follow the Ocaml rules for infix and prefix notation. An
operator is a string of symbols
%
\begin{quote}
  \verb.! $ % & * + - / \ : < = > ? @ \^ | ~.
\end{quote}
% $
where:
%
\begin{itemize}
\item a \emph{prefix operator} is one that starts with \texttt{?},
  \texttt{!} or \texttt{\char126}. It can be used as a unary operation.
\item \emph{infix operators} can be used as binary operations and have
  four levels of precedence, listed from lowest to highest:
  \begin{itemize}
    \item left-associative operators starting with \texttt{=},
      \texttt{<}, \texttt{>}, \texttt{|}, \texttt{\&}, \texttt{\$}
    \item right-associative operators starting with \texttt{@} and \texttt{\^}
    \item left-associative operators starting with \texttt{+}, \texttt{-},
      and \texttt{\char92}
    \item left-associative operators starting with \texttt{*}, \texttt{/}, and \texttt{\%} 
    \item right-associative operators starting with \texttt{**}.
  \end{itemize}
  %
  An operator $\circ$ is \emph{left-associative} if $x \circ y \circ
  z$ is understood as $(x \circ y) \circ z$, and
  \emph{right-associative} if $x \circ y \circ z$ is understood as $x
  \circ (y \circ z)$. If you look at the above list again, you will
  notice that operators have the expected precedence and
  associativity. However, if you are unsure about precedence, it is
  best to use a couple of extra parentheses.
\end{itemize}

\subsection{Axioms}

An axiom has the form
%
\begin{source}
Axiom /@[name]@/: /@<formula>@/.
\end{source}
%
or
%
\begin{source}
Theorem /@[name]@/: /@<formula>@/.
\end{source}
%
There is no difference between an axiom and a theorem as far as alg is
concerned. A good convention is to use \texttt{Axiom} for the actual
axioms and \texttt{Theorem} for statements that are consequences of
axioms and are worth including in the theory because they make alg run
faster, see Section~\ref{sec:optimization}.

The optional \texttt{\textit{[name]}} is a string of of letters,
digits and the underscore characters. Alg has no use for names, they
are there for the user. The \texttt{\textit{<formula>}} is a
first-order formula built from the following logical operations,
listed in order of increasing precedence:
%
\begin{center}
  \begin{tabular}{rcl}
    $\forall x\, .\, \phi$ & is written as & \texttt{forall $x$, $\phi$}, \\
    $\exists x\, .\, \phi$ & is written as & \texttt{exists $x$, $\phi$}, \\
    $\phi \Leftrightarrow \psi$ & is written as & \texttt{$\phi$ <-> $\psi$} or \texttt{$\phi$ <=> $\psi$},\\
    $\phi \Rightarrow \psi$ & is written as & \texttt{$\phi$ -> $\psi$} or \texttt{$\phi$ => $\psi$},\\
    $\phi \lor \psi$ & is written as & \texttt{$\phi$ {\char92}/ $\psi$} or \texttt{$\phi$ or $\psi$},\\
    $\phi \land \psi$ & is written as & \texttt{$\phi$ /{\char92} $\psi$} or \texttt{$\phi$ and $\psi$},\\
    $\lnot \phi$ & is written as & \texttt{not $\phi$},\\
    $s = t$ & is written as & \texttt{$s$ = $t$},\\
    $s \neq t$ & is written as & \texttt{$s$ <> $t$} or \texttt{$s$ != $t$},\\
    $\top$ and $\bot$ & are written as & \texttt{True} and \texttt{False}, respectively.
  \end{tabular}
\end{center}
%
An iterated quantification $\forall x_1 \,.\, \forall x_2 \,.\, \cdots
\forall x_n \,.\, \phi$ may be written as
%
\begin{center}
\texttt{forall $x_1$ $x_2$ $\ldots$ $x_n$ , $\phi$.}
\end{center}
%
and similarly for $\exists$.

Axioms may contain free variables. Thus we can write just
%
\begin{source}
Axiom: x + y = y + x.
\end{source}
%
instead of
\begin{source}
Axiom: forall x y, x + y = y + x.
\end{source}
%

\section{Output}
\label{sec:output-files}

\subsection{Description of the output}
\label{sec:description-output}

The output of alg is meant to be self-explanatory. Nevertheless, here
is what the output consists of:
%
\begin{description}
\item[Title:] the name of the theory.
\item[Theory:] the input file, which can be suppressed with %
  \texttt{--no-source} command-line option.
\item[Models:] a list of the models found. This can be
  suppressed with the \texttt{--count} command-line option. Each model
  has a name \texttt{\textit{theory\_name\_$n$\_$m$}}
  where $n$ is the model size and $m$ is the model sequence number. If
  a model can be decomposed, a decomposition into indecomposable
  factors is given.\footnote{Please note that in general such a
    decomposition is \emph{not} unique.} Tables of all the operations
  and relations are displayed.
\item[Counts:] a table showing how many models of each size were found.
  If more than three sizes were considered, alg also provides a URL to
  query the counts at \texttt{http://oeis.org/}, the On-Line
  Encyclopedia of Integer Sequences.
\end{description}

\subsection{Available output formats}
\label{sec:output-formats}

Alg supports several output formats. The default is plain text and it
is sent to the screen. You can choose one of the following formats
with the \texttt{--format} command-line option:
%
\begin{itemize}
\item \texttt{text}: the default format is plain text. Actually, it is
  not entirely plain, as it is also valid Markdown.\footnote{According
    to Wikipedia, \emph{Markdown} is a lightweight markup language,
    originally created by John Gruber and Aaron Swartz to help maximum
    readability and "publishability" of both its input and output
    forms.}
\item \texttt{html}: Hypertext Markup Language, used for web pages.
\item \texttt{latex}: {\LaTeX} format, suitable for showing
  multiplication tables in published papers.
\item \texttt{json}: the JSON format, suitable for futher processing,
  as explained in Section~\ref{sec:json}.
\end{itemize}

If you specify an output file with the \texttt{--output} option but no
\texttt{--format}, alg guesses the correct format from the output
filename extension.

\subsection{Redirection of output to a file}

By default alg prints results on the standard output. You may redirect
the output to a file with the \texttt{--output} option. If you use
\texttt{--output} without \texttt{--format}, alg tries to guess the
output format from the filename extension.

\subsection{Output in JSON format for futher processing}
\label{sec:json}

For further processing of output use the JSON output format by
specifying \texttt{--format json} or output to a file with the
\texttt{.json} extension.

The JSON output has one of two forms, depending on whether the
\texttt{--count} option is used. Without it, the output is a list
%
\begin{source}
["/@theory_name@/", $M_1$, ..., $M_n$]
\end{source}
%
where $M_1, \ldots, M_n$ are the models found. Each model $M_i$ is
given as a dictionary which maps constants, unary operations and
binary operations, predicates and relations to the corresponding
integers, tables and matrices. For example, the only commutative ring
of size~$6$ with unit is presented as
%
\begin{shell}
{
  "0" : 0,
  "1" : 4,
  "~" : [0, 2, 1, 3, 5, 4], 
  "+" :
    [
      [0, 1, 2, 3, 4, 5], 
      [1, 2, 0, 4, 5, 3], 
      [2, 0, 1, 5, 3, 4], 
      [3, 4, 5, 0, 1, 2], 
      [4, 5, 3, 1, 2, 0], 
      [5, 3, 4, 2, 0, 1]
    ], 
  "*" :
    [
      [0, 0, 0, 0, 0, 0], 
      [0, 1, 2, 0, 1, 2], 
      [0, 2, 1, 0, 2, 1], 
      [0, 0, 0, 3, 3, 3], 
      [0, 1, 2, 3, 4, 5], 
      [0, 2, 1, 3, 5, 4]
    ]
}
\end{shell}
%
The underlying set of the ring is $\{0,1,2,3,4,5\}$, the neutral
elements for addition and multiplication are $0$ and $4$,
respectively, and the operations are given as lookup tables, for
example, $\mathop{\texttt{\char126}} 1 = 2$ and $4
\mathbin{\texttt{*}} 3 = 3$.

The \texttt{--count} option gives JSON output
%
\begin{source}
["/@theory_name@/", [[$i_1$,$k_1$], ..., [$i_n$,$k_n$]]]
\end{source}
%
which is read as saying that there are $k_j$ models of size $i_j$.

In Python you can import JSON data from a file
\texttt{mystuff.json} like this:
%
\begin{source}
import json
with open('mystuff.json','r') as f:
    mystuff = json.load(f)
\end{source}

In Mathematica just use the \texttt{Import["\textit{mystuff.json}"]}
command.

\section{Command-line Options}
\label{sec:command-line-options}

Alg is used as
%
\begin{shell}
alg --size /@<sizes>@/ /@[options]@/ /@<theory.th>@/
\end{shell}
%
where \texttt{\textit{theory.th}} is the input file, and the options are:
%
\begin{description}
\item[\texttt{--size \textit{<sizes>}}]
  A comma-separated list of sizes that alg should consider. You can
  also specify a size interval of the form
  \texttt{\texttt{m}-\textit{n}}. For example, \texttt{1,2,5-8} would
  mean that we consider sizes 1, 2, 5, 6, 7, 8.
\item[\texttt{--count}]
  Do not print out the models, just report the counts.
\item[\texttt{--format \textit{<format>}}]
  Output in the given format. Supported formats are \texttt{text},
  \texttt{html}, \texttt{latex}, and \texttt{json}.
\item[\texttt{--indecomposable}]
  Output only indecomposable models, i.e., those that are not products
  of smaller models.
\item[\texttt{--axiom}]
  Add an extra axiom to the theory. Use the option several times to
  add several axioms. Note that on a command-line the axiom
  should be enclosed in quotes.
\item[\texttt{--no-products}] Do not try to generate models as
  products of smaller models. Use this option if you know that a model
  cannot be a product of smaller ones. For example, a field can never
  be a product of two fields. The option is assumed if the theory
  contains predicates or relations. If all of your axioms are
  equations, then you should \emph{not} use this option.
\item[\texttt{--no-source}]
  Do not include the theory in the output.
\item[\texttt{--output \textit{<filename>}}]
  Output to the given file rather than to screen.
\item[\texttt{--paranoid}]
  Perform additional checks to verify that the models really satisfy
  the axioms. Use this option if you think there is a bug in alg.
\item[\texttt{--sat}]
  Use the alternative algorithm based on satisfying the axioms rather
  than intelligent filling-in of multiplication tables. It works well
  with theories that have predicates and relations. For theories with
  unary and binary operations the standard algorithm typically
  performs better.
\item[\texttt{--version}]
  Print out version information and exit.
\item[\texttt{--help}]
  Print help.
\end{description}

\section{How to use alg efficiently}
\label{sec:optimization}

You should always keep in mind the fact that alg performs a brute
force search with a few optimizations. In the worst case its running
time is doubly exponential in the size of the models because there are
$n^{n^2}$ tables for a binary operation on a set of size $n$.

Alg contains two diffrent algorithms, the \emph{default} and the
\emph{alternative} one. As a rule of thumb you should use the
default algorithm, unless the signature of your theory consists mostly
of predicates and relations. In any case, since the performance is not
easily predicted, you should try both algorithms and experiment by
rewriting the theory in various equivalent ways.

\subsection{The default algorithm}
\label{sec:default-algorithm}

The default alg algorithm is optimized for \emph{equational} theories,
i.e., those whose axioms are equations (semigroups, monoids, groups,
rings, lattices, etc., but \emph{not} integral domains and fields).
Alg takes advantage of commutativity, associativity and idempotent
laws, and to a smaller extent of other kinds of equational laws, such
as absorption and distributivity.

Alg performs few optimizations based on non-equational axioms. Thus
you should try to reduce their number. Furthermore, in non-equational
axioms the quantifiers should always be pushed inside as much as
possible. For example, instead of
%
\begin{shell}
Axiom: forall x, exists y, x <> 0 -> x * y = 1.
\end{shell}
%
you should write
%
\begin{shell}
Axiom: forall x, x <> 0 -> exists y, x * y = 1.
\end{shell}
%
The best kind of axioms are those that allow alg to immediately fill in
a whole column or row. Typically these are axioms about neutral
elements, such as $1 \cdot x = x$ and $0 + x = x$. As a rule of thumb,
every such axiom will increase the maximum manageable size by one.

In general alg performs better if it is given more axioms and
theorems, because each additional statement cuts down the
possibilities. Thus you \emph{should} include theorems which already
follow from other axioms. For example:
%
\begin{itemize}
\item state \emph{both} $1 \cdot x = x$ and $x \cdot 1 = x$, even if
  one of them follows from the other,
\item more generally, state all versions of a symmetric equation, even
  if they all follow from one of them,
\item state laws like $0 \cdot x = 0$ (and also $x \cdot 0 = x$), even
  if they follow from other axioms.
\end{itemize}

You should declare as many constants and as few operations as
possible. A typical example is the theory of lattices. For
\emph{finite} structures the following are equivalent theories:
%
\begin{itemize}
\item a lattice with operations $\land$, $\lor$,
\item a bounded lattice with operations $\land$, $\lor$
  and constants $0$, $1$,
\item a $\lor$-semilattice with operation $\lor$ and constant $0$,
\item a bounded $\lor$-semilattice with operation $\lor$
  and constants $0$, $1$.
\end{itemize}
%
The best choice is the last one because it has just fewest operation and
most constants. Indeed, figuring out that there are 53 lattices of size
7 takes 250 times longer with the theory of a lattice than with the
theory of a bounded $\lor$-semilattice.

Lastly, we should mention that alg generates tables in the order in
which the operations are declared. Sometimes it is much easier to
generate tables for one operation than another, so you should experiment
by switching the order of declarations. For example, the theory of a
ring works much faster if addition $+$ is declared before
multiplication $\times$.

\subsection{The alternative algorithm}
\label{sec:altern-algor}

The alternative algorithm transforms the given axioms into constraints
that need to be satisfied. It then solves the constraints in all
possible ways by intelligent backtracking. The general rules for
efficient use of the alternative algorithm are the same as those for
the default one.

It turns out that the alternative algorithm generally performs worse
than the default one when the theory consists mostly of operations.
However, the alternative algorithm usually outperforms the default one
for theories which constist mostly of relations.

\section{Support and bug reports}
\label{sec:support-bug-reports}

Please send bug reports and whishes to the authors: Andrej Bauer
(\texttt{Andrej.Bauer@andrej.com}) and Aleš Bizjak
(\texttt{Ales.Bizjak0@gmail.com}). If you report a bug, please send us
the exact version number of alg, as printed out with the
\texttt{--version} command-line option.

The Mathematics and Computation blog at
\texttt{http://math.andrej.com} may contain further information and
discussion about alg.

\end{document}
```
