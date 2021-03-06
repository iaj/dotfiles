XPTemplate priority=personal
XPTinclude
    \ _common/personal

XPT tt wrap=text hint=\\texttt{...}
\texttt{`text^}`cursor^

XPT ss hint=\\subsection{...}
\subsection{`^}`cursor^

XPT sss hint=\\subsubsection{...}
\subsubsection{`^}`cursor^

XPT s hint=\\section{...}
\section{`^}`cursor^

XPT code hint=\\begin{lstlisting}...\\end{lstlisting}
\begin{lstlisting}
`cursor^
\end{lstlisting}

XPT '' hint="rhs
\grqq{}

XPT todo hint=\\colorbox{red}{...}
\colorbox{red}{TODO: `^}

XPT `` hint="lhs
\glqq{}

XPT fn hint=\\footnote{...}
\footnote{`^}`cursor^

XPT l hint=\\label{...}
\label{`^}`cursor^

XPT e wrap=text hint=\\emph
\emph{`text^}`cursor^

XPT b wrap=text hint=\\textbf
\textbf{`text^}`cursor^

XPT enumerate hint=\\begin{enumerate}...\\end{enumerate}
\begin{enumerate}
\item `cursor^
\end{enumerate}

XPT itemize hint=\\begin{itemize}...\\end{itemize}
\begin{itemize}
\item `cursor^
\end{itemize}

XPT description hint=\\begin{description}...\\end{description}
\begin{description}
\item [`description^] `cursor^
\end{description}

XPT i hint=\\item
\item `cursor^

XPT fig hint=\\begin{figure}...\\end{figure}
\begin{figure}[h]
    \begin{center}
        \includegraphics[width=.8\hsize]{`filename^}
    \end{center}
    \caption{\label{`mark^}%
    `caption^}
\end{figure}

XPT main
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{graphicx}
\usepackage[ngerman]{babel}
`cursor^

XPT dinb hint=letter
\documentclass[a4paper, 12pt]{dinbrief}
\usepackage[utf8x]{inputenc}
\usepackage{ngerman}
\signature{Jörg Schmalfuß}
\address{Jörg Schmalfuß\\ 
         Alt-Höchst 2\\
         65929 Frankfurt}
\backaddress{J.Schmalfuß, Alt-Höchst 2, 65929 Frankfurt}

\begin{document}

\subject{`sub?^}
\begin{letter}{
    `an...^
}
\opening{`anrede^}

`cursor^

\closing{mit freundlichen Grüßen,}
\end{letter}
\end{document}
