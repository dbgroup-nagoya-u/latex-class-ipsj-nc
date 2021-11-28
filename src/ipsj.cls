% This is file "ipsj.cls",
% LaTeX Class File for some conferences of IPSJ (e.g., the national convention
% and the forum on information technology).
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{ipsj}[2021/11/28 v3.0.0 for National Convention of IPSJ]

% Forward class options to Bxjscls
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{bxjsarticle}
}

% Process given options
\ProcessOptions\relax

% Loading "bxjsarticle.cls" with above options
\LoadClass[
  a4paper,
  9pt,
  twocolumn,
  notitlepage,
  ja=standard,
]{bxjsarticle}

%----------------------------------------------------------------------------- %
% Layout settings
%----------------------------------------------------------------------------- %
% set margins
\setpagelayout+{
  left=20truemm,
  right=20truemm,
  top=30truemm,
  bottom=25truemm,
  noheadfoot,
}

\pagestyle{empty}

%------------------------------------------------------------------------------%
% Macros to input a title, authors, and affiliations
%------------------------------------------------------------------------------%
\renewcommand{\title}[2][]{
  \def\@jpTitle{#1}
  \def\@enTitle{#2}
}

\newcount\@authorCnt
\@authorCnt=0
\renewcommand{\author}[3][]{
  \expandafter\def\csname @jpAuthor\number\@authorCnt\endcsname{#1}
  \expandafter\def\csname @enAuthor\number\@authorCnt\endcsname{#2}
  \expandafter\def\csname @authorLabel\number\@authorCnt\endcsname{#3}
  \advance\@authorCnt by1
}

\newcount\@afflCnt
\@afflCnt=0
\newcommand{\affiliation}[3][]{
  \@tempcnta=\@afflCnt
  \advance\@tempcnta by1
  \expandafter\edef\csname @#3\endcsname{\the\@tempcnta}
  \@namedef{@jpAffiliation\number\@afflCnt}{#1}
  \@namedef{@enAffiliation\number\@afflCnt}{#2}
  \advance\@afflCnt by1
}

%------------------------------------------------------------------------------%
% Macros to modify the descriptions of authors and affiliations for title
%------------------------------------------------------------------------------%
% Definition of reference marks for affiliations.
\def\@afflRefMark#1{\ifcase#1 \or % \ensuremath{
 \dagger\or
 {\dagger}{\dagger}\or
 {\dagger}{\dagger}{\dagger}\or
 {\dagger}{\dagger}{\dagger}{\dagger}\or
 {\dagger}{\dagger}{\dagger}{\dagger}{\dagger}\or
 {\dagger}{\dagger}{\dagger}{\dagger}{\dagger}{\dagger}\or
 {\dagger}{\dagger}{\dagger}{\dagger}{\dagger}{\dagger}{\dagger}\or
 {\dagger}{\dagger}{\dagger}{\dagger}{\dagger}{\dagger}{\dagger}{\dagger}\or
 {\dagger}{\dagger}{\dagger}{\dagger}{\dagger}{\dagger}%
  {\dagger}{\dagger}{\dagger}\or
 *\or {*}{*}\or {*}{*}{*}\or {*}{*}{*}{*}\or
  {*}{*}{*}{*}{*}\or {*}{*}{*}{*}{*}{*}\or %% ((((((((((((((((((((
 a)\or b)\or c)\or d)\or e)\or f)\or g)\or h)\or i)\or j)\or
 k)\or l)\or m)\or n)\or o)\or p)\or q)\or r)\or s)\or t)
 \fi
}

% Generating refference marks from an author index.
\newcommand{\@genAfflRefMarks}[1]{%
  \edef\@tempAffilLabelList{\csname @authorLabel\number#1\endcsname}%
  \@tempcntb=0
  \@for\@tempAfflLabel:=\@tempAffilLabelList\do{%
    \edef\@tempAfflIdx{\csname @\@tempAfflLabel\endcsname}%
    \ifnum\@tempcntb=0
      $^{\@afflRefMark{\@tempAfflIdx}}$%
    \else
      $^{,\@afflRefMark{\@tempAfflIdx}}$%
    \fi
    \advance\@tempcntb by1
  }%
}

% Generating a list of authors' names in Japanese. If there are multiple authors
% and multiple affiliations, reference marks are output.
\newcommand{\@jpAuthorList}{
  \@tempcnta=0
  \loop\ifnum\@tempcnta<\@authorCnt
    \ifnum\@authorCnt>1
      \ifnum\@afflCnt>1 % multiple authors and multiple affiliations
        \mbox{%
          \csname @jpAuthor\number\@tempcnta\endcsname
          \@genAfflRefMarks{\@tempcnta}}%
      \else
        \mbox{\csname @jpAuthor\number\@tempcnta\endcsname}%
      \fi
    \else
      \mbox{\csname @jpAuthor\number\@tempcnta\endcsname}%
    \fi
    \quad
    \advance\@tempcnta by1
  \repeat
}

% Generating a list of authors' names in English. If there are multiple authors
% and multiple affiliations, reference marks are output.
\newcommand{\@enAuthorList}{
  \@tempcnta=0
  \loop\ifnum\@tempcnta<\@authorCnt
    \ifnum\@authorCnt>1
      \ifnum\@afflCnt>1 % multiple authors and multiple affiliations
        \mbox{%
          \csname @enAuthor\number\@tempcnta\endcsname
          \@genAfflRefMarks{\@tempcnta}}%
      \else % multiple authors but one affiliation
        \mbox{\csname @enAuthor\number\@tempcnta\endcsname}%
      \fi
    \else % only one author
      \mbox{\csname @enAuthor\number\@tempcnta\endcsname}%
    \fi
    \advance\@tempcnta by1
    \ifnum\@tempcnta<\@authorCnt % output "," or "and" among authors' names
      \@tempcntb=\@tempcnta
      \advance\@tempcntb by1
      \ifnum\@tempcntb<\@authorCnt % two or more authors remain
        ,
      \else % the next author is last
        \ifnum\@authorCnt=2 \ and \else , and \fi
      \fi
    \fi
  \repeat
}

% Generating a list of affiliations' names in Japanese. If there are multiple
% authors and multiple affiliations, reference marks are output.
\newcommand{\@jpAfflList}{
  \@tempcnta=0
  \@tempcntb=1
  \loop\ifnum\@tempcnta<\@afflCnt
    \ifnum\@authorCnt>1
      \ifnum\@afflCnt>1
        \mbox{$^{\@afflRefMark{\number\@tempcntb}}$\csname @jpAffiliation\number\@tempcnta\endcsname}%
      \else
        \mbox{\csname @jpAffiliation\number\@tempcnta\endcsname}%
      \fi
    \else
      \mbox{\csname @jpAffiliation\number\@tempcnta\endcsname}%
    \fi
    \quad
    \advance\@tempcnta by1
    \advance\@tempcntb by1
  \repeat
}

% Generating a list of affiliations' names in Japanese. If there are multiple
% authors and multiple affiliations, reference marks are output.
\newcommand{\@enAfflList}{
  \@tempcnta=0
  \@tempcntb=1
  \loop\ifnum\@tempcnta<\@afflCnt
    \ifnum\@authorCnt>1
      \ifnum\@afflCnt>1
        $^{\@afflRefMark{\number\@tempcntb}}$\csname @enAffiliation\number\@tempcnta\endcsname
      \else
        \csname @enAffiliation\number\@tempcnta\endcsname
      \fi
    \else
      \csname @enAffiliation\number\@tempcnta\endcsname
    \fi
    \advance\@tempcnta by1
    \advance\@tempcntb by1
    \ifnum\@tempcnta<\@afflCnt
      \\
    \fi
  \repeat
}

%----------------------------------------------------------------------------- %
% Override "\maketitle"
%----------------------------------------------------------------------------- %
\renewcommand{\maketitle}{\par
%----------------------------- modified ------------------------------%
\begingroup
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\advance\leftskip 1\jsZw
    \parindent 1\jsZw\noindent
    \llap{\@textsuperscript{\normalfont\@thefnmark}\hskip0.3\jsZw}##1}%
  \twocolumn[\@maketitle]
  \long\def\@makefntext##1{\parindent 0pt\noindent##1}%
  \if@english\else
    \footnotetext{%
      \@enTitle\\
      \@enAuthorList\\
      \@enAfflList}%
  \fi
  \plainifnotempty
  \@thanks
\endgroup
%---------------------------------------------------------------------%
\setcounter{footnote}{0}%
\global\let\thanks\relax
\global\let\maketitle\relax
\global\let\@thanks\@empty
\global\let\@author\@empty
\global\let\@date\@empty
\global\let\@title\@empty
\global\let\title\relax
\global\let\author\relax
\global\let\date\relax
\global\let\and\relax
\bxjs@annihilate@subtitle
}

\def\@maketitle{%
\newpage\null
\begin{center}%
  \let\footnote\thanks
  {\LARGE\sffamily \if@english \@enTitle \else \@jpTitle \fi\par}%
  \vskip 1em
  {\large\sffamily
  \lineskip .5em
  \tabcolsep 0pt
  \begin{tabular}[t]{p{169truemm}}%
    \centering
    \if@english \@enAuthorList \else \@jpAuthorList \fi\\
    \vskip .5em
    \if@english \@enAfflList \else \@jpAfflList\fi
  \end{tabular}\par}%
\end{center}%
\par\vskip 2em
}

%----------------------------------------------------------------------------- %
% Override "thebibliography" environment
%----------------------------------------------------------------------------- %
\renewenvironment{thebibliography}[1]{%
  \@jsc@warnoldfontcmdexceptiontrue
  \global\let\presectionname\relax
  \global\let\postsectionname\relax
  \section*{\refname}\@mkboth{\refname}{\refname}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      %-------- modified ---------%
      \small
      \setlength\baselineskip{10pt}
      %---------------------------%
      \@openbib@code
      \usecounter{enumiv}%
      \let\p@enumiv\@empty
      \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy
   \clubpenalty4000
   \@clubpenalty\clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m
}
{\def\@noitemerr
{\@latex@warning{Empty `thebibliography' environment}}%
\endlist}

\endinput
