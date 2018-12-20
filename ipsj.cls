% This is file "ipsj.cls",
% LaTeX Class File for the national convention of IPSJ. 
%
\NeedsTeXFormat{pLaTeX2e}
\ProvidesPackage{ipsj}
  [2017/12/28]% version 1.0.0 generated by Kento Sugiura
\LoadClass[a4j,10pt,twocolumn,autodetect-engine]{jsarticle}

%-------------------------------------------------------------------------------- %
% Layout settings
%-------------------------------------------------------------------------------- %
% set margins
\RequirePackage{geometry}
\geometry{inner=20mm,outer=20mm,top=30mm,bottom=25mm}

% no page numbers
\pagestyle{empty}

% reduce the line spacing
\renewcommand{\baselinestretch}{0.90}

%-------------------------------------------------------------------------------- %
% Macros to input a title, authors, and affiliations
%-------------------------------------------------------------------------------- %
\renewcommand{\title}[2]{
  \def\@jpTitle{#1}
  \def\@enTitle{#2}
}

\newcount\@authorCnt
\@authorCnt=0
\renewcommand{\author}[3]{
  \expandafter\def\csname @jpAuthor\number\@authorCnt\endcsname{#1}
  \expandafter\def\csname @enAuthor\number\@authorCnt\endcsname{#2}
  \expandafter\def\csname @authorLabel\number\@authorCnt\endcsname{#3}
  \advance\@authorCnt by1
}

\newcount\@afflCnt
\@afflCnt=0
\newcommand{\affiliation}[3]{
  \@tempcnta=\@afflCnt
  \advance\@tempcnta by1
  \expandafter\edef\csname @#1\endcsname{\the\@tempcnta}
  \@namedef{@jpAffiliation\number\@afflCnt}{#2}
  \@namedef{@enAffiliation\number\@afflCnt}{#3}
  \advance\@afflCnt by1
}

%-------------------------------------------------------------------------------- %
% Macros to modify the descriptions of authors and affiliations for title layout
%-------------------------------------------------------------------------------- %
% definition of reference marks for affiliations
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

% generate refference marks from an author index
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

% generate a list of authors' names in japanese
% if there are multiple authors and multiple affiliations, reference marks are output
\newcommand{\@jpAuthorList}{
  \@tempcnta=0
  \loop\ifnum\@tempcnta<\@authorCnt
    \ifnum\@authorCnt>1
      \ifnum\@afflCnt>1 % multiple authors and multiple affiliations
        \mbox{\csname @jpAuthor\number\@tempcnta\endcsname\@genAfflRefMarks{\@tempcnta}}%
      \else
        \mbox{\csname @jpAuthor\number\@tempcnta\endcsname}%
      \fi
    \else
      \mbox{\csname @jpAuthor\number\@tempcnta\endcsname}%
    \fi
    \quad\quad
    \advance\@tempcnta by1
  \repeat
}

% generate a list of authors' names in english
% if there are multiple authors and multiple affiliations, reference marks are output
\newcommand{\@enAuthorList}{
  \@tempcnta=0
  \loop\ifnum\@tempcnta<\@authorCnt
    \ifnum\@authorCnt>1
      \ifnum\@afflCnt>1 % multiple authors and multiple affiliations
        \mbox{\csname @enAuthor\number\@tempcnta\endcsname\@genAfflRefMarks{\@tempcnta}}%
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

% generate a list of affiliations' names in japanese
% if there are multiple authors and multiple affiliations, reference marks are output
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

% generate a list of affiliations' names in japanese
% if there are multiple authors and multiple affiliations, reference marks are output
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

%-------------------------------------------------------------------------------- %
% Title layout
%-------------------------------------------------------------------------------- %
% redefine the command "maketitle"
\renewcommand{\maketitle}{\par
  \begingroup
    \twocolumn[\@maketitle]%
    \long\def\@makefntext##1{\parindent 0pt\noindent##1}%
    \footnotetext{\@enTitle \\ \@enAuthorList \\ \@enAfflList}%
  \endgroup
  \setcounter{footnote}{0}%
}

\def\@maketitle{%
  \newpage\null
  \begin{center}%
    \vskip -4mm
    {\LARGE \@jpTitle \par}%
    \vskip .5em
      \lineskip .5em
      \begin{tabular}[t]{p{15cm}}%
      \centering
      {\large\@jpAuthorList}\\ \vskip 1mm
      \@jpAfflList
      \end{tabular}\par%
  \end{center}%
  \par\vskip 1em
}