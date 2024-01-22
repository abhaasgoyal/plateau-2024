\ProvidesClass{plateau}[November 2022 PLATEAU class]
\newif\if@suppmat\@suppmattrue
\DeclareOption{nosupp}{\@suppmatfalse}
\ProcessOptions\relax
\ExecuteOptions{}
\LoadClass{article}

\RequirePackage{etoolbox,xpatch}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{setspace}
\RequirePackage[table]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{rotating}
\RequirePackage[compact]{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage[style]{abstract}
\RequirePackage[marginal]{footmisc}
\RequirePackage{caption,subcaption}
\RequirePackage[inline]{enumitem}
\RequirePackage{authblk}
\RequirePackage{relsize}
\RequirePackage[right]{lineno}
\RequirePackage{mfirstuc}
\RequirePackage{textcase}

\RequirePackage[
    type={CC},
    modifier={by},
    version={4.0},
]{doclicense}

% fonts
\RequirePackage[standard-baselineskips]{cmbright}
\RequirePackage{fontspec}


\def\@keyandsep{ and }
\renewcommand\Authand{\@keyandsep}
\renewcommand\Authands{\@keyandsep}

\RequirePackage{textcomp}
\RequirePackage[absolute]{textpos}
\RequirePackage{amsmath,amsfonts,amssymb,amsthm}
\RequirePackage{adjustbox}
\RequirePackage{longtable,booktabs,tabularx}

\newcommand{\tlprintlicense}{This work is licensed under a Creative Commons Attribution 4.0 International License.}
\def\@keywordsname{Keywords}
\def\@authornotename{Author's notes}
\def\@keycorrauthorname{Corresponding author}
\def\@corrauthorname{\@keycorrauthorname}
\def\@keyeditorname{Organizers}
\def\@editortext{\@keyeditorname}
\def\@runningauthor{}
\def\@journalname{}
\def\@editorname{}
\def\@corrauthor{}
\def\@authornote{}
\def\@articledoi{}
\def\@articleid{}
\definecolor{TLLightGreen}{RGB}{184,198,36}
\definecolor{TLDarkGreen}{RGB}{56,52,49}
\definecolor{TLDarkGray}{RGB}{153,153,153}

\RequirePackage{microtype}
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\setstretch{1.15}

\RequirePackage{geometry}
\geometry{a4paper, 
  left=4.75cm,top=1.75cm,bottom=2.4cm,right=1.5cm,
  footskip=1.5\baselineskip,footnotesep=\baselineskip,headheight=21\p@,headsep=\baselineskip}

\RequirePackage{xstring}

\newcommand{\runningauthor}[1]{\def\@runningauthor{#1}}
\newcommand{\journalname}[1]{\def\@journalname{#1}}
\newcommand{\authornote}[1]{\def\@authornote{#1}}
\newcommand{\corrauthor}[1]{\def\@corrauthor{#1}}
\newcommand{\editorname}[1]{\def\@editorname{#1}}
\newcommand{\articledoi}[1]{\def\@articledoi{#1}\articleid{\articleenumber}}
\newcommand{\articleenumber}{\StrRight{\@articledoi}{5}}
\newcommand{\articleid}[1]{%
 \ifthenelse{\isempty{#1}}%
 {\def\@articleid{e\articleenumber}}% if #1 is empty
 {\def\@articleid{e#1}}% if #1 is not empty
}
%\newcommand{\articleid}[1]{\def\theaid{#1}\ifx\theaid\empty{\def\@articleid{e\articleenumber}}\else{\def\@articleid{e\theaid}}\fi}
%\newcommand{\articleid}[1]{\def\@articleid{#1}}


\renewcommand{\Authfont}{\large\bfseries}
\renewcommand{\Affilfont}{\small\itshape\mdseries}
\renewcommand\AB@authnote[1]{\textsuperscript{#1}}
\renewcommand\AB@affilnote[1]{\textsuperscript{#1}}
\setlength{\affilsep}{\baselineskip}

\newcommand{\printifnotempty}[3]{%
  \sbox0{#3}%
  \ifdim\wd0=0pt
    {}% if #2 is empty
  \else
    {\textcolor{TLDarkGreen}{\bfseries #1: }{#2}#3}% if #2 is not empty
  \fi
}

\newcommand{\more@metadata}{%
  \@cover@logo\par
  \printifnotempty{DOI}{}{\@articledoi}\par
  \printifnotempty{\@corrauthorname}{\\}{\@corrauthor}\par
  \printifnotempty{\@editortext}{\\}{\@editorname}\par
  \tlprintlicense
}

\newcommand{\@cover@logo}{%
  \minsizebox{0.9\textwidth}{1ex}{PLATEAU}\\
  \minsizebox{0.9\textwidth}{1ex}{13th Annual Workshop at the}\\
  \minsizebox{0.9\textwidth}{1ex}{Intersection of PL and HCI} 
}

\def\thevolume#1{\gdef\@thevolume{#1}}
\def\thenumber#1{\gdef\@thenumber{#1}}
\def\theyear#1{\gdef\@theyear{#1}}


\newcounter{cntothertitle}
\newcommand\othertitle[1]{%
  \stepcounter{cntothertitle}%
  \csdef{othertitle\thecntothertitle}{#1}}
\newcommand\getothertitle[1]{%
  \csuse{othertitle#1}}

\newcounter{ititle}
\newcommand\printothertitles[1]{%
  \setcounter{ititle}{0}%
  \whileboolexpr
    { test {\ifnumcomp{\value{ititle}}{<}{#1}} }%
    {\stepcounter{ititle}\Large\smaller[\the\numexpr\value{ititle}-1\relax]%
	%\makefirstuc{\expandafter\MakeTextLowercase{\getothertitle{\theititle}}}\par%
	\getothertitle{\theititle}\par%
    }
  }

\newcommand{\@insert@metadata}{%
  \begin{textblock*}{3.3cm}[0,1](1cm,\dimexpr\paperheight-\Gm@bmargin\relax)
  \scriptsize\raggedright%
  \setlength{\parskip}{\baselineskip}%
  \setlength{\parindent}{\z@}%
  \more@metadata\par
  \end{textblock*}
}
\AtBeginDocument{
\renewcommand{\@maketitle}{%
  \@insert@metadata%
  \noindent\begin{minipage}{0.9\linewidth}
  \raggedright\setstretch{1.0}
  %{\LARGE\bfseries{\makefirstuc{\expandafter\MakeTextLowercase{\@title}}}\par}
  {\LARGE\bfseries{\@title}\par}
  {\printothertitles{\thecntothertitle}}
  \vskip\baselineskip
  \@author\par
  \end{minipage}\bigskip\normalfont\normalsize%
}
\appto{\maketitle}{%
  \ifdefvoid{\@authornote}{}{\begingroup
    \renewcommand{\thefootnote}{}
    \footnotetext{\emph{\@authornotename:} \@authornote}%
  \endgroup}%
}

%%%%%%%%%%%
%% keywords 
\def\sep{\unskip. }%
\newcommand{\capitalizekeywords}[2][\sep]{%
  \def\dolist##1{\expandafter\@dolist##1#1\@eol}%
  \def\@dolist##1#1##2\@eol{%
    \begingroup\setbox0=\hbox{##1\unskip}\ifdim\wd0=0pt\endgroup\else\endgroup\ignorespaces\makefirstuc{##1}\unskip\sep\fi%
    \ifx\@eol##2\@eol\else\@dolist##2\@eol\fi}%
  \dolist{#2}%
}

\renewcommand{\abstitlestyle}[1]{{\large\bfseries #1\par}}
\setlength{\absleftindent}{\z@}
\setlength{\absrightindent}{\absleftindent}
\preto{\abstract}{%
  \setlength{\parindent}{\z@}%
  \newcommand{\keywords}[1]{%
  \emph{\@keywordsname}: \capitalizekeywords{#1}\par
  }
}
\appto{\abstract}{%
  \setlength{\parindent}{\z@}%
  \setlength{\parskip}{1em}%
  \vskip-\parskip%
  \noindent\ignorespaces%
}

} % end AtBeginDocument

\newenvironment{polyabstract}
{\noindent\textcolor{TLLightGreen}{\rule{\linewidth}{1.0pt}}\par}
{\vspace{-1.5ex}\noindent\textcolor{TLLightGreen}{\rule{\linewidth}{.5pt}}\par}

\titleformat{\section}{\large\bfseries}{\hspace*{-1em}\makebox[\z@][r]{\thesection}}{1em}{}
\titleformat{\subsection}{\large}{\hspace*{-1em}\makebox[\z@][r]{\thesubsection}}{1em}{}
\titleformat{\subsubsection}{\normalsize}{\hspace*{-1em}\makebox[\z@][r]{\thesubsubsection}}{1em}{}
\titlespacing*{\section}{\z@}{\baselineskip}{\z@}
\titlespacing*{\subsection}{\z@}{\baselineskip}{\z@}
\titlespacing*{\subsubsection}{\z@}{\baselineskip}{\z@}
\setcounter{secnumdepth}{3}

\setlist{leftmargin=*,nosep}

\setlength{\footnotemargin}{-1em}
\pretocmd{\@makefntext}{%
  \renewcommand{\@makefnmark}{\thefootnote}
}{}{}

\RequirePackage{totpages}

\fancyhf{}
\renewcommand{\footrulewidth}{1.5\p@}
\renewcommand{\headrule}{}
\preto{\footrule}{\begingroup\color{TLLightGreen}}
\appto{\footrule}{\endgroup}
%\fancyfootoffset[LE,RO]{\marginparsep+\marginparwidth}
\fancyfootoffset[L]{3.25cm}
\fancyfoot[R]{\small\thepage/\pageref*{TotPages}}
\fancyfoot[L]{\small\emph{\@runningauthor}\enskip|\enskip\@journalname\enskip|\enskip{v.\@thevolume}\enskip|\enskip{n.\@thenumber}\enskip|\enskip\@articleid\enskip|\enskip\@theyear}
\pagestyle{fancy}
\fancypagestyle{plain}{%
  \fancyhf{}
  \renewcommand{\footrule}{}
  \fancyfoot[R]{\small\thepage/\pageref*{TotPages}}
}

\captionsetup*{singlelinecheck=false,font={small},labelfont={bf,color=TLDarkGreen},labelsep=period}
\captionsetup*[table]{position=top}
\captionsetup*[sub]{labelfont=small,justification=centering}
\newcommand{\headrow}{\rowcolor{TLDarkGray}}
\newcommand{\thead}[1]{\bfseries #1\rule[-1.2ex]{0pt}{2em}}
\renewcommand{\arraystretch}{1.2}

\RequirePackage[backend=biber,style=ieee]{biblatex}
\renewcommand{\bibfont}{\small}

\PassOptionsToPackage{hyphens}{url}
\RequirePackage[breaklinks=true,pdfauthor=PLATEAU]{hyperref}
\renewcommand{\UrlBreaks}{\do\/\do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z}
\hypersetup{colorlinks,allcolors=TLDarkGreen}
\urlstyle{same}

\newcommand{\textNotes}{Note:}
\newcommand{\notes}[1]{
 \captionsetup{skip=0ex,position=b}%
 \caption*{\textcolor{TLDarkGreen}{\textit{\textNotes}} {#1}}
}
%%%% source/notes END


\RequirePackage{academicons}
% ORCID
\newcommand{\orcid}[1]{\href{https://orcid.org/#1}{\textcolor[HTML]{B8C624}{\aiOrcid}}}
% A6CE39

% BEGIN \citefirstlastauthor 
% reference: https://tex.stackexchange.com/questions/581792/how-to-write-the-authors-full-name-and-avoid-style-formatting-given-by-biblatex/581838#581838
\DeclareCiteCommand{\citefirstlastauthor}
  {\DeclareNameAlias{labelname}{given-family}%
   \let\multinamedelim\multinamedelimorig
   \let\finalnamedelim\finalnamedelimorig
   \let\mkbibnamefamily\origmkbibnamefamily
   \let\mkbibnamegiven\origmkbibnamegiven
   \let\mkbibnameprefix\origmkbibnameprefix
   \let\mkbibnamesuffix\origmkbibnamesuffix
   \boolfalse{citetracker}%
   \boolfalse{pagetracker}%
   \usebibmacro{prenote}}%
  {\ifciteindex%
     {\indexnames{labelname}}%
     {}%
   \printtext[bibhyperref]{\printnames{labelname}}}%
  {\multicitedelim}%
  {\usebibmacro{postnote}}%
% END \citefirstlastauthor



%%%% AUTHORS CONTRIBUTIONS %%% BEGIN
\newcommand{\contributorssecname}{%
  \iflanguage{english}{Author contributions}{%
  \iflanguage{french}{Les contributions de l'auteur}{%
  \iflanguage{german}{Autorenbeiträge}{%
  \iflanguage{spanish}{Contribuciones del autor}{%
  \iflanguage{portuguese}{Contribuições dos autores}{Author Contributions}
  }}}}}

\newenvironment{contributors}[1]
{
\section*{\fontsize{10}{12}\selectfont \contributorssecname}\label{#1}
\begin{singlespace}
\fontsize{8}{10}\selectfont\noindent
\begin{itemize*}[before=\unskip{\hspace{-1ex}},itemjoin={{; }},label={}]
}
{
\end{itemize*}
\end{singlespace}
\normalsize
}

\newcommand{\txcconceptualization}{\textbf{Conceptualization}:}

\newcommand{\txcdatacuration}{\textbf{Data curation}:}

\newcommand{\txcformalanalysis}{\textbf{Formal analysis}:}

\newcommand{\txcfundingaquisition}{\textbf{Funding acquisition}:}

\newcommand{\txcinvestigation}{\textbf{Investigation}:}

\newcommand{\txcmethodology}{\textbf{Methodology}:}

\newcommand{\txcprojectadm}{\textbf{Project administration}:}

\newcommand{\txcresources}{\textbf{Resources}:}

\newcommand{\txcsoftware}{\textbf{Software}:}

\newcommand{\txcsupervision}{\textbf{Supervision}:}

\newcommand{\txcvalidation}{\textbf{Validation}:}

\newcommand{\txcvisualization}{\textbf{Visualization}:}

\newcommand{\txcwritingdraft}{\textbf{Writing -- original draft}:}

\newcommand{\txcwritingreview}{\textbf{Writing -- review and editing}:}
%%%% AUTHORS CONTRIBUTIONS %%% END

\RequirePackage{minted} % Code highlighting
\usepackage{mdframed} % Boxed Hypothesis

