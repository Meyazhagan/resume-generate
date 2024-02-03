\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2023/01/11 v0.2 Resume class]

\LoadClass[11pt,letterpaper]{article} % Font size and paper type

\usepackage[left=0.5in,top=0.4in,right=0.5in,bottom=0.4in]{geometry} % set document margins
\usepackage[parfill]{parskip} % Remove paragraph indentation

\usepackage{etoolbox}
\usepackage{keycommand}
\usepackage{xstring}
\usepackage{hyperref}
\usepackage{multicol}
\usepackage{fontawesome5}
\hypersetup{
    colorlinks=true,
    linkcolor=blue,
    urlcolor=black,
}

\usepackage{tabularx}

%to prevent spillover of tabular into next pages
\usepackage{supertabular}
\usepackage{tabularx}
\newlength{\fullcollw}
\setlength{\fullcollw}{0.42\textwidth}

% Load the fontspec package to set the font
\usepackage[scaled]{helvet} % Load the Helvetica font
\renewcommand\familydefault{\sfdefault} % Set the  font family to sans-serif
\usepackage[T1]{fontenc} % Use the T1 font encoding to ensure proper character rendering

\pagestyle{empty}

% -------------- README --------------
% Visit https://github.com/vgnshiyer/ASU-sparkysundevil-resume-template for comprehensive documenation.

% ------------ Utilities ------------

\def \separator {
    \textbf{\Large\textbullet}
}

\newcommand{\email}[1]{\href{mailto:#1}{#1}}%
\newcommand{\profilelink}[1]{\href{https://#1}{#1}}%

\newcommand{\isA}[1]{
    \expandafter\ifstrequal\expandafter{#1}{default}{}{a}
}

\newcommand\sectionTitle[1]{%
    \begingroup
        \large{\textbf{\MakeUppercase{#1}}}
        \vspace{0.4em}
        \hrule
        \vspace{-0.3em}
    \endgroup
}%

% ------------------------------------

% ------------- Header --------------
\newcommand\printNameTitle[1]{%
    \begingroup
        \hfill{\MakeUppercase{\Huge\bfseries #1}}\hfill
        \vspace{0.5em}
        \break
        {
            \MakeUppercase{full-stack developer}\separator\MakeUppercase{Open source contributor}
        }
        \break
        \vspace{-0.5em}
        \hrule
        \vspace{-0.25em}
    \endgroup
}%

\newkeycommand{\introduction}[
    fullname,
    email,
    phone,
    linkedin,
    github
]{%
    \begin{center}%
        \printNameTitle{\commandkey{fullname}}% Full name title
        {
        \hfill
        \faIcon{envelope} \email{\commandkey{email}} \hfill
        \faIcon{linkedin} \profilelink{\commandkey{linkedin}} \hfill
        \faIcon{github} \profilelink{\commandkey{github}} \hfill
        \faIcon{phone} \commandkey{phone} \hfill
        }
    \end{center}%
}%


\newenvironment{resumeSection} [1] {
    \sectionTitle{#1}
}

\newkeycommand{\openSourceItem} [
    title,
    pr,
    description
] {
    \begingroup
        \textbf{\commandkey{title}} \hfill \profilelink{\commandkey{pr}}
        \break
        \vspace{-2em}
        \commandkey{description}
        \vspace{-0.5em}
    \endgroup
}

\newkeycommand{\experienceItem} [
    position,
    technology,
    description
] {
    \begingroup
        \textbf{\commandkey{position}} \hfill {\commandkey{technology}}
        \break
        \vspace{-2em}
        \commandkey{description}
        \vspace{-0.5em}
    \endgroup
}

\newkeycommand{\projectTitle}[
    project,
    projectUrl,
    technology
] {
    \large{\textbf{\href{https://\commandkey{projectUrl}}{\commandkey{project}}}} \hfill 
    \normalsize{\textsl{\commandkey{technology}}}
    \break
}

\newkeycommand{\educationItem}[
    college,
    degree,
    duration,
    cgpa
] {
    \vspace{0.25em}
    \textbf{\commandkey{degree}} \hspace*{2ex} \commandkey{college}\hspace*{2ex} \commandkey{cgpa} CGPA  \hfill   \commandkey{duration}
    \break
}

\newkeycommand{\skillSection}[
 categories,
 tools
]{
    \begin{tabular}{ m{5em} m{40em}}
     \textbf{Language} & Javascript, Typescript, Go, C\#, Python, Java \\
     \textbf{Frontend} & HTML, CSS, Tailwind CSS, Material UI, React, Redux  \\
     \textbf{Backend} & Node.js, Express, .Net, RestAPI, GraphQL, GRPC, .NET Core \\
     \textbf{Database} & MongoDB, MySQL, SQL Server Postgres, Influx DB, Redis DB, SQLite \\
     \textbf{Tools} & Git, Github, Docker, Kubernetes, AWS - EC2, Lamda, S3 buckets, Linux 
    \end{tabular}
}

