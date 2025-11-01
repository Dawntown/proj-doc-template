
## Motivation

All note-taking processes are output-oriented, so the ultimate goal is to produce a report that can be shared and displayed. $\LaTeX$ and Beamer are the most commonly used tools for generating PDF reports, slides, and articles.

During the ideation and validation stages, we use Markdown to jot down fragmented ideas. Once these fragments mature into more refined research concepts, they can be consolidated into the LaTeX system. Relatively independent small pieces are recorded in Obsidian, such as various probability distributions and their properties, derivations and assumptions of loss functions, theoretical foundations of basic models, etc. The advantage is that all the knowledge points learned can be connected across domains to form a personal knowledge network. Parts requiring experimental discussion can be directly written and recorded in LaTeX, which makes it easier to incorporate more powerful LLMs for organization, editing, and polishing.

In the process of writing my first paper, I discovered another advantage of LaTeX: outputting multiple types of reports from a single content base, including reports, slides, and papers. Different forms of reporting emphasize different aspects: reports are inclusive and contain everything, including immature ideas, planned experiments, technical details in progress, and failed experimental results—but these can be verbose and unfocused; slides emphasize modularization, conciseness, logical flow, and visual effects; and the final paper requires rigorous argumentation and data support, and is obtained after multiple rounds of revision based on feedback from reports and slides. By composing content in LaTeX, language models can more easily help us summarize, link, organize, and generate various forms of outputs, thereby saving repetitive work.

Below are the LaTeX and Beamer templates I am currently using:

## Tree structures

```plaintext
workspace/
 ├─ assets/
 │    ├─ fonts/
 │    └─ images/
 ├─ figcodes/ 
 │    ├─ data/ --> OneDrive to sync large data files
 │    ├─ figs/ --> OneDrive to sync large number of images
 │	  │   ├─ fig-board.ai # project illustration source file linking to all important individual figures 
 │    │   ├─ PDF/         # exported artboards in fig-board.ai
 │    │   └─ *.pdf        # figs for specific element
 │    ├─ tabs/     # tables in txt or csv formate
 │    ├─ myutils/  # common plotting and analysis functions or scripts
 │    ├─ figure_<expr_name>.ipynb # save pdf to figs/
 │    └─ illustration_<element_name>.ipynb # save pdf to figs/
 ├─ figures/ # wrapped final figures for manuscripts
 │    ├─ figure_<short_desc>.tex
 │    └─ sfig_<short_desc>.tex
 ├─ drafts/
 │    └─ <timestamp>_<short_desc>.tex  # intermediate drafts>
 ├─ outputs/ --> OneDrive to sync final reports, slides, and papers
 │	  ├─ report_<timestamp>.pdf
 │    ├─ slides_<timestamp>.pdf
 │    └─ manuscript_<timestamp>.pdf
 ├─ sections/
 │    ├─ intro.tex
 │    ├─ methods.tex
 │    ├─ results.tex
 │    ├─ discussion.tex
 │    ├─ conclusion.tex
 │    └─ supp.tex
 ├─ manuscript/
 │    ├─ preamble.tex        # style settings for manuscript
 │    └─ manuscript.tex      # linking all sections together
 ├─ slides/
 │    ├─ CUHK.sty            # CUHK beamer theme with purple header, golden title, and navigation dots
 │    ├─ preamble.tex        # style settings for beamer slides
 │    └─ slides.tex          # LLM summarized key points to generate slides for certain presentation chance
 ├─ report/
 │    ├─ preamble.tex        # style settings for report
 │    └─ report.tex          # linking involved drafts to generate report for certain week
 ├─ .gitignore
 ├─ preamble_base.tex        # basic packages and settings for all outputs
 ├─ ref.bib                  # bibliography file
 └─ setup_links.sh           # different device has its own path settings for symlinking the above folders
```

  