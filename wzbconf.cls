%% Author: Michael Piotrowski <mxp@dynalabs.de>

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wzbconf}[2018/01/21 Document class for Weizenbaum Conference papers]

\PassOptionsToClass{a4paper, 12pt}{article}
\LoadClass{article}

\RequirePackage{ifthen}

%% Page layout
\RequirePackage[total={17cm, 25.7cm}, top=2cm]{geometry}
\RequirePackage{setspace} \linespread{1.15}

\setlength{\topsep}{0pt}
\setlength{\parindent}{0pt}
\setlength{\columnsep}{0.85cm}

%% Font setup.  XeLaTeX (and TeX Gyre Termes) is required to follow
%% the specs that require bold small caps for section headings.  Times
%% New Roman, as generally shipped with operating systems, doesn't
%% have small caps, let alone bold small caps.  We could use
%% \RequireXeTeX to enforce this if we wanted to.

\RequirePackage{ifxetex}

\ifthenelse{\boolean{xetex}}{
  \RequirePackage{fontspec}
  \setmainfont[Mapping=tex-text]{TeX Gyre Termes}
}{}

%% If biblatex is loaded, number references

\AtBeginDocument{%
  \@ifpackageloaded{biblatex}{%
    % If biblatex is loaded
    \defbibenvironment{bibliography}
    {\enumerate[label={\arabic*.}, leftmargin=*]
      {}
      {\setlength{\labelwidth}{\labelnumberwidth}%
        \setlength{\labelsep}{\biblabelsep}%
        \addtolength{\leftmargin}{\labelsep}%
        \setlength{\itemsep}{\bibitemsep}%
        \setlength{\parsep}{\bibparsep}}%
      \renewcommand*{\makelabel}[1]{\hss##1}}
    {\endenumerate}
    {\item}

    % Use colon between title and subtitle
    \renewcommand{\subtitlepunct}{\addcolon\addspace}
  }{
    % If biblatex is not loaded, do nothing
  }
}{}

%% Captions

\RequirePackage[labelfont=bf, textfont=bf, justification=centering]{caption}
\DeclareCaptionFont{mysize}{\fontsize{9}{9.6}\selectfont}
\captionsetup{font=mysize}

%% No page headers or footers, no page numbers

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}

%% Abstract

\RequirePackage[style]{abstract}

\renewcommand{\absnamepos}{flushleft}
\renewcommand{\abstitlestyle}[1]{%
  \hspace*{0.8cm}{\fontsize{16}{16}\selectfont\bfseries\scshape #1}}
\renewcommand{\abstracttextfont}{\normalsize\mdseries}
\setlength{\absleftindent}{0pt}
\setlength{\absrightindent}{0pt}
\setlength{\abstitleskip}{-10pt}

%% Keywords

\newenvironment{keywords}{%
  \begin{flushleft}%
  {\fontsize{16}{16}\vspace{18pt}\selectfont\bfseries\scshape\hspace*{0.8cm}Keywords}\par%
  \vspace{6pt}%
  \normalsize\mdseries%
}{\par\end{flushleft}}

%% Section Headings

\RequirePackage{sectsty}
\sectionfont{\fontsize{16}{16}\selectfont\scshape\bfseries}
\subsectionfont{\fontsize{14}{16}\selectfont\bfseries\scshape}

\RequirePackage{titlesec}
\titlespacing*{\section}{0pt}{12pt}{6pt}
\titlespacing*{\subsection}{0pt}{12pt}{6pt}

%% Footnotes

\renewcommand{\@makefntext}[1]{%
  \setlength{\parindent}{0mm}%
  \normalfont\textsuperscript{\@thefnmark}\enspace#1%
}

%% Title and Authors (adapted from acl2017.sty)

\newlength\titlebox 
\setlength\titlebox{5cm}

\newcommand\outauthor{
  \begin{tabular}[t]{c}
    \bfseries\@author
  \end{tabular}}

% Mostly taken from deproc.
\def\maketitle{\par
  \let\thetitle\@title % Make title available as \thetitle in the document
 \begingroup
   \def\thefootnote{\fnsymbol{footnote}}
   \def\@makefnmark{\hbox to 0pt{$^{\@thefnmark}$\hss}}
   % \twocolumn[\@maketitle] \@thanks
   \@maketitle \@thanks
 \endgroup
 \setcounter{footnote}{0}
 \let\maketitle\relax \let\@maketitle\relax
 \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax}
\def\@maketitle{\vbox to \titlebox{\hsize\textwidth
 \linewidth\hsize \vskip 0.125in minus 0.125in \centering
 {\fontsize{18}{18}\selectfont\bfseries\@title \par} \vskip 0.2in plus 1fil minus 0.1in
 {\def\and{\unskip\enspace{\rm and}\enspace}%
  \def\And{\end{tabular}\hss \egroup \hskip 1in plus 2fil 
           \hbox to 0pt\bgroup\hss \begin{tabular}[t]{c}\bf}%
  \def\AND{\end{tabular}\hss\egroup \hfil\hfil\egroup
          \vskip 0.25in plus 1fil minus 0.125in
           \hbox to \linewidth\bgroup\large \hfil\hfil
             \hbox to 0pt\bgroup\hss \begin{tabular}[t]{c}\bf}
  \hbox to \linewidth\bgroup\normalsize \hfil\hfil
    \hbox to 0pt\bgroup\hss 
	\outauthor
   \hss\egroup
    \hfil\hfil\egroup}
  \vskip 0.3in plus 2fil minus 0.1in
}}
