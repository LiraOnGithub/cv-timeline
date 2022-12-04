\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}
\LoadClass{article}

\RequirePackage{fontspec}
\RequirePackage[english]{babel}
\RequirePackage[parfill]{parskip}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{positioning, shapes}

\RequirePackage [absolute,overlay]{textpos}
\RequirePackage{hyperref}
\RequirePackage{fontawesome5}
\RequirePackage{enumitem}
\RequirePackage{tabularx}

\newcommand\padding{1cm}
\newcommand\iconDistance{.5em}
\newcommand\iconWidth{2em}

\newcommand\sidebarWidth{7cm}
\newcommand\sidebarSectionPadding{.5cm}

\newcommand\historyCircleSize{2em}
\newcommand\historyCircleDistance{1.5em}
\newcommand\historyItemDistance{.25em}

\newcommand\logoWidth{\dimexpr\sidebarWidth-\padding-\padding\relax}
\newcommand\mainWidth{\paperwidth-\sidebarWidth}
\newcommand\contentWidth{\dimexpr%
	\mainWidth-\padding-\padding-\historyCircleSize/2-\historyCircleDistance%
	\relax}
\newcommand\contentOffset{\dimexpr\sidebarWidth+\padding\relax}

\RequirePackage
	[ top=\padding
	, left=\contentOffset
	, bottom=\padding
	, right=\padding
	, noheadfoot
	]{geometry}

\setlength{\topskip}{0cm}
\setlength{\parindent}{0cm}
\setlength{\parskip}{0cm}
\setlength{\marginparsep}{0cm}
\setlength{\marginparwidth}{0cm}
\setlength{\marginparpush}{0cm}

% lengths for textpos package
\setlength{\TPHorizModule}{\padding}
\setlength{\TPVertModule}{\TPHorizModule}

\setlist{nolistsep, leftmargin=0cm, topsep=0cm, partopsep=0cm}

\definecolor{darkblue}{HTML}{71b8e6}

%https://tex.stackexchange.com/questions/68272/make-section-headings-invisible/68296#68296
\newcommand\invisiblesection[1]{
  \refstepcounter{section}
  \addcontentsline{toc}{section}{\protect\numberline{\thesection}#1}
  \sectionmark{#1}
}

\newenvironment{profile}[1]{%
	\begin{tikzpicture}[overlay, remember picture]
		\node
			[ rectangle
			, fill=darkblue
			, anchor=north west
			, minimum width=\sidebarWidth
			, minimum height=\paperheight
			] (sidebar) at (current page.north west){};
	\end{tikzpicture}
	\textblock{5}(1,1)
		\invisiblesection{Profile}
		\includegraphics[width=\logoWidth]{#1}\\[\padding]
		% https://en.wikibooks.org/wiki/LaTeX/Tables#@_and_!_expressions
		% @{} is used to get rid of extra space
		\tabularx{\textwidth}{@{} c@{\hspace{\iconDistance}} X@{}}}
	{\endtabularx
	\endtextblock}
\newcommand\profileItem[2]{#1&#2\\}
\newcommand\profileItemWithGap[2]{#1&#2\\\noalign{\vspace{\sidebarSectionPadding}}}

% We use \tabularx instead of \begin{tabularx} because of some bug in tabularX. See https://mirrors.evoluso.com/CTAN/macros/latex/required/tools/tabularx.pdf, chapter 5 Macros, item \tabularx.
\newenvironment{details}
	{\vspace{0.5em}\tabularx{\textwidth}{@{} >{\centering} p{1.5em}@{\hspace{0.5em}} X@{}}}
	{\endtabularx}
\newcommand\detailItem[2]{#1&#2\\}

\newcommand\historyItemGraphics[4]{
	\node[darkblue, label=center:#2] (#1) {};
	\node[
		clabel,
		#4,
		right=\historyCircleDistance of #1,
		anchor=base west
	] (clabeltext) at (#1) { #3 };
}
\newcommand\historyItem[5]{
	\historyItemGraphics{#1}{#2}{
		#3 \hfill #4

		#5
	}{level1} \& \\
}
\newcommand\historyspacer[1]{
	\node[historycircle] (#1) {};
}
\newcommand\historySubItem[5]{
	\historyspacer{#1-sp} \& \historyItemGraphics{#1}{#2}{
		#3 \hfill #4

		#5
	}{level2} \\[.5em]
}
\newcommand\historySeperator{
	\node[historycircle] (forSeperator) {};
	\node[
		ellipse,
		fill=darkblue,
		minimum height=.1em,
		minimum width=\contentWidth/2,
		right=\contentWidth/4 of forSeperator
	] (seperator) {}; \& \\
}

\newcommand\connect[2]{\path (#1) to [out=90,in=-90] (#2);}

\newcommand\timeline[2]{
	\invisiblesection{Timeline}

	\tikzstyle{historycircle} = [circle, draw=none, inner sep=0cm, minimum size=\historyCircleSize]
	\tikzstyle{darkblue}=[historycircle, fill=darkblue, line width=0cm]
	\tikzstyle{clabel} = [outer sep=0cm, align=left]

	\tikzstyle{level1} = [text width=\contentWidth]
	\tikzstyle{level2} = [text width=\dimexpr\contentWidth-\historyCircleSize\relax]

	\tikzstyle{every path} = [draw=darkblue, line width=2pt]

	\begin{tikzpicture}
		\matrix[
			column sep={\historyCircleSize,between origins},
			row sep=\historyItemDistance,
			ampersand replacement=\&,
			outer sep=0cm,
			inner sep=0cm
		]{#1};
		#2
	\end{tikzpicture}
}

% get rid of page numbers
\pagestyle{empty}
