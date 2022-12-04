# cv-timeline
Class I created for my own CV
 - It creates a panel on the left to separate information about you and the journey you have taken in life;
 - It shows your journey in a way that allows both academia and work to be combined (achievements can be included in your profile);
 - It is minimal, you only need to specify what you want to show in your profile and what you want to show in the timeline.

# How your CV can look
![image](https://user-images.githubusercontent.com/1878071/205492328-ef09dffe-1ab3-4f22-ae4f-501b11bc9259.png)
The information at the bottom of the profile is only included to give credit. You will not have that in your own CV ;)

# How to use
Start with the documentclass, profile and timeline:
```tex
\documentclass[a4paper]{cv-timeline}
\begin{document}

  \begin{profile}{YOUR PICTURE}
  
  \end{profile}
  
  \timeline{}{}

\end{document}
```
## Profile
`profile` can contain `\profileItem`s and `\profileItemWithGap`s. They are the same aside from the fact that -WithGap will also leave the next line blank.
First argument is the icon, second argument is the text.
```tex
  \begin{profile}{...}
    \profileItem{someicon}{some information}
    \profileItemWithGap{someicon}{some information}
    \profileItem{someicon}{some information}
  \end{profile}
```
## Timeline
### First argument
The first argument of `\timeline` can contain `\historyItem`s, `\historySubItem`s and `\historySeperator`s.
`\historyItem` and `\historySubItem` both have the same arguments:
```tex
\historyItem{name}{icon}{title}{date}{content}
\historySubItem{name}{icon}{title}{date}{content}
```
`\historySeperator` can be used to place a line between `\historyItem`s to visually separate them better.
### Second argument
The second argument is to call `\connect{A}{B}` for all items from the first argument. A is the oldest entry, B is a newer entry.
```tex
\profile{
  \historyItem{C}
  \historyItem{B}
  \historySubItem{A1}
  \historyItem{A}
}{
  \connect{B}{C}
  \connect{A}{B}
  \connect{A}{A1}
}
```
If you connect multiple `\historySubItem`s to one `\historyItem` it can cause overlap. To overcome that you can also use the name of another `\historySubItem` followed by "-sp".
```tex
\profile{
  \historyItem{C}
  \historyItem{B}
  \historySubItem{A2}
  \historySubItem{A1}
  \historyItem{A}
}{
  \connect{B}{C}
  \connect{A}{B}
  \connect{A1-sp}{A2}
  \connect{A}{A1}
}
```
