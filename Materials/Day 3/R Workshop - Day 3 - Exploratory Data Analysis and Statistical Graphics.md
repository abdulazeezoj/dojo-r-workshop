# R Workshop -- Day 3 -- Exploratory Data Analysis and Statistical Graphics

**Session 3 of 7 | Duration: 3 hours**
**Programme:** Applied R for Statistical Teaching, Research and Reproducible Analysis

## Learning objectives

By the end of this session you will be able to:

1. Start from a research question and choose a chart type that answers it, rather than choosing a chart type first.
2. Explain and use the grammar of graphics: data, aesthetics, geoms, scales, labels and themes.
3. Build and interpret bar charts, histograms, box plots and scatter plots in `ggplot2`.
4. Add titles, axis labels and units so a plot stands on its own.
5. Export publication-ready graphics to a file.
6. Write a visual claim that is accurate about what the chart can and cannot show.

## Capstone link

Today you produce the first visual evidence for your capstone report: three exported, interpreted graphics built from the cleaned anchor dataset (`Data/processed/anchor_dataset_clean.csv`, produced on Day 2).

## Segment plan (3 hours)

| Segment | Time | Purpose |
| --- | ---: | --- |
| Opening and recap | 10 min | Reload the clean anchor dataset, recap the research question |
| Concept bridge | 25 min | Question-led plotting and the grammar of graphics |
| Guided coding | 60 min | Bar chart, histogram, box plot, scatter plot |
| Participant practice | 45 min | Build and label three graphics on the anchor dataset |
| Interpretation and reporting | 25 min | Write a two- to three-sentence interpretation per plot |
| Evidence log and capstone update | 15 min | Export and log the three graphics |

---

## Part 1 -- Concept bridge (Core workshop activity)

### Start with the question, not the chart

A chart type is a means, not an end. Three workshop-relevant questions and their natural chart types:

| Question | Natural chart |
| --- | --- |
| How many lecturers are in each training track? | Bar chart of counts |
| How is post-training score distributed? | Histogram |
| Does post-training score differ by training track? | Box plot, score by track |
| Is post-training score related to attendance? | Scatter plot |

If you find yourself with a question and no obvious chart, it is worth restating the question more precisely before opening `ggplot2`.

### The grammar of graphics, briefly

`ggplot2` builds a plot in layers:

- **data** -- the data frame.
- **aesthetics (`aes()`)** -- which columns map to which visual properties (x, y, colour, fill).
- **geoms** -- the visual representation (`geom_bar()`, `geom_histogram()`, `geom_boxplot()`, `geom_point()`).
- **scales** -- how data values map to visual ranges (axis breaks, colour palettes).
- **labels and themes** -- titles, axis labels, units, and overall appearance.

Every `ggplot2` call you write this week follows the same shape:

```r
ggplot(data, aes(x = ..., y = ...)) +
  geom_...() +
  labs(title = "...", x = "...", y = "...") +
  theme_minimal()
```

---

## Part 2 -- Guided coding (Core workshop activity)

```r
library(tidyverse)

lecturers <- read_csv("Data/processed/anchor_dataset_clean.csv", show_col_types = FALSE)
```

### 2.1 Bar chart -- counts by training track

```r
ggplot(lecturers, aes(x = training_track)) +
  geom_bar(fill = "#2C7FB8") +
  labs(
    title = "Participants by training track",
    x = "Training track", y = "Number of participants"
  ) +
  theme_minimal()
```

*Interpretation example:* "Online was the most common track, followed by In-Person and then Blended. This affects how much weight an Online-driven result should carry in later analysis."

### 2.2 Histogram -- distribution of post-training scores

```r
ggplot(lecturers, aes(x = post_score)) +
  geom_histogram(binwidth = 5, fill = "#41AB5D", colour = "white") +
  labs(
    title = "Distribution of post-training scores",
    x = "Post-training score (0-100)", y = "Number of participants"
  ) +
  theme_minimal()
```

`binwidth` controls how fine-grained the histogram is. Try 2, 5 and 10 and discuss how the same data can look smoother or noisier purely from a plotting choice -- this is itself an honesty-in-graphics point.

### 2.3 Box plot -- score by training track

```r
ggplot(lecturers, aes(x = training_track, y = post_score)) +
  geom_boxplot(fill = "#FEB24C") +
  labs(
    title = "Post-training score by training track",
    x = "Training track", y = "Post-training score (0-100)"
  ) +
  theme_minimal()
```

A box plot shows the median, the interquartile range and likely outliers in one view -- a natural bridge into the Day 5 question of whether track is associated with score.

### 2.4 Scatter plot -- score against attendance

```r
ggplot(lecturers, aes(x = attendance, y = post_score)) +
  geom_point(alpha = 0.6, colour = "#6A51A3") +
  labs(
    title = "Post-training score by attendance",
    x = "Attendance (%)", y = "Post-training score (0-100)"
  ) +
  theme_minimal()
```

### 2.5 Export

```r
dir.create("Outputs", showWarnings = FALSE)

p_track_counts <- ggplot(lecturers, aes(x = training_track)) +
  geom_bar(fill = "#2C7FB8") +
  labs(title = "Participants by training track",
       x = "Training track", y = "Number of participants") +
  theme_minimal()

ggsave("Outputs/day3_bar_track_counts.png", p_track_counts, width = 7, height = 5, dpi = 300)
```

Always export at a fixed `width`/`height`/`dpi` so figures look the same in your report regardless of your current RStudio window size.

### 2.6 Writing a cautious visual claim

A chart shows association, not cause. Compare:

- *Overclaiming:* "Attendance increases post-training scores."
- *Accurate:* "Participants with higher attendance tended to have higher post-training scores in this sample; this plot does not establish that attendance caused the difference."

---

## Part 3 -- Participant practice (Core workshop activity)

Using `lecturers`, produce and export **three** graphics, each with a two- to three-sentence interpretation:

1. One categorical-summary chart (bar chart) for a variable of your choice (e.g. `region`, `institution_type`, `completed`).
2. One distribution chart (histogram or box plot) for `pre_score` or `post_score`.
3. One relationship chart (scatter plot) connecting two numeric variables, or a box plot connecting a category to a numeric variable, relevant to your research question.

For each: add a title, axis labels with units, export to `Outputs/`, and write your interpretation as a comment directly above the `ggsave()` call.

A facilitator-reviewed solution is in `Solution-Scripts/day3_eda_solution.R`.

---

## Optional demonstration

- **Density plots and violin plots** -- smoother alternatives to histograms/box plots; flag that both can mislead with very small groups (e.g. fewer than ~10 observations per group).
- **Two-way categorical graphics** -- stacked or grouped bar charts, e.g. `completed` by `training_track`.
- **Faceting** -- `facet_wrap(~ training_track)` to repeat one chart across groups.
- **Missing-data visualisation** -- a simple bar chart of `colSums(is.na(lecturers))`.
- **Honest versus misleading graphics** -- truncated y-axes, 3D pie charts, dual axes with mismatched scales.

```r
# Optional: faceted histogram of post_score by training_track
ggplot(lecturers, aes(x = post_score)) +
  geom_histogram(binwidth = 5, fill = "#41AB5D", colour = "white") +
  facet_wrap(~ training_track) +
  labs(title = "Post-training score by training track", x = "Post-training score", y = "Count") +
  theme_minimal()
```

---

## Reference or take-home material

- Theme customisation: `theme()`, `theme_bw()`, `theme_classic()`, institutional colour palettes.
- Annotation approaches: `geom_text()`, `geom_label()`, `annotate()`.

---

## Daily deliverable

Three exported graphics from the anchor dataset (`Outputs/day3_*.png`), each with a two- to three-sentence interpretation saved alongside the script.

### Evidence log entry

Complete the Day 3 row in `Workshop-Evidence-Log.md`: list the three graphics produced and note one early pattern in the data relevant to your research question.

---

## Facilitator notes

- If a participant's research question does not map naturally onto bar/histogram/box plot/scatter, help them restate the question rather than forcing an awkward chart type.
- Watch for binwidth and bar-width choices made purely for aesthetics without checking whether they hide or exaggerate a pattern -- this is a good moment to circle back to the "honest versus misleading graphics" discussion even if it is technically optional.
- Confirm every exported PNG actually has a title and axis labels before participants move on; an unlabelled plot is treated as incomplete for the deliverable.
