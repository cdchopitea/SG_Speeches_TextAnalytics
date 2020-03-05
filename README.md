<!DOCTYPE html>
# Understanding the United Nations Secretary General’s Political Agenda: using Rstudio to analyze speeches
<i>Analyzing speeches by the United Nations Secretary General using text analytics tools and packages in R </i>


<div align="justify">
 <b> 1.	 Background </b>
The United Nations International Fund for Agricultural Development (IFAD) alongside the Food and Agriculture Organization, World Food Program and other UN-agencies are working in partnership to create a world Summit on Food Systems in 2021 to be convened by the UN Secretary-General (SG), Antonio Guterres.  The concept was to present a project proposal to the SG and ask for his endorsement and leadership. In September, before the UN General Assembly (UNGA) 2019, he agreed to convene the Summit, and the agencies had to prepare a launching and Summit process strategy.
As a text analyst at IFAD I was tasked with analyzing speeches by the SG in to make a data-driven decision for the launching and process strategy. The initial proposal suggested the Summit was set to initiate during the UNGA of 2019. On the other hand, there was evidence to believe that the SG has not taken on the issue of “food” as an essential part of his agenda inferring time should be allowed to build upon this issue. The idea was for the SG to use the high-level week (UNGA) to begin discussing public issues related to food systems from then on. 
In short, the goal of this study is the following: 
1)	Analyzed what issues the SG talks about, what is in his agenda, and identify if he is discussing food or food systems, if he does, how has he framed it.
2)	To compare, since he agreed to convene the Summit, has he discussed the issue of food systems publicly? 

<b>2.	Methodology </b> 
For this analysis, a total of 215 speeches were analyzed. The speeches were divided into two groups: The first group (SG1) contains speeches dating January 18, 2019, to September 16, 2019 (end of 74th Session of the General Assembly and the month the SG agreed to convene the Summit). The second group (SG2) contains speeches dating from September 17, 2019, to February 8, 2020 (after it was agreed that there is a need to be built momentum) (access speeches here).
 Rstudio was used to conduct the analysis and the frameworks used include frequency analysis, correlation analysis, and sentiment and network analysis (please see R code in the Appendix).
 
<b>3.	Findings</b>
<i>3.1 Frequency Analysis</i>
For group one, SG1, the most frequently used words are ‘climate’ followed by ‘world’, ‘people’ and ‘development’. If one looks at what the SG has been doing throughout 2019, these words matched with the discourse he is creating: In 2019 he convened the Climate Action Summit and has framed climate change as a central issue, critical to the achievement of the 2030 Agenda for Sustainable Development (Hertsgaard, 18; United Nations, 2019).  The frequency of these words suggests that issues related to climate and development are at the top of his agenda (see Figure 1). Since he mentioned climate so often, it could have been expected that he would make a greater emphasis on youth as he claims that involving youth and youth leadership is central to climate action (General, 2019). 
Group two, SG2, is not too different than SG1 and it does not appear that “food” or “systems” have been highly incorporated in its speeches. He only mentioned ‘food’ a total of 15 times since September compared to ‘climate’ (398 times), and he mentioned ‘hunger’ only 7 times (see Figure 2).

<div align="center">
 
<img src= "https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/frequency_SG1.png" width="450" height="550" />

Figure 1: UN Secretary-General word frequency from dating January 18, 2019, to September 16, 2019 (SG1) and filtered based on over 150 repetitions.

![frequency SG2](https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/frequency_SG2.png)
 
Figure 2: UN Secretary-General word frequency from dating September 17, 2019, to February 08, 2020 (SG1) and filtered based on over 150 repetitions.

</div>

<i>3.2 Relationship between SG1 and SG2</i>
Furthermore, a correlogram was built to compare the relationship between the two sets of speeches (see Figure 3). Viewing the correlogram we can observe that the SG’s agenda has stayed much the same between the two periods, consistently discussing issues such as climate change. The two groups are highly similar and as a result, they have a very high correlation (of 94%). This result indicates that his agenda has remained much or less the same.

<div align="center">
 
![corrologram](https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/corrologram.png)
 
Figure 3: Correlogram between SG1 and SG2

</div>

<i>3.3 Bigrams and quadrograms: Observing relationships between words </i>

<i>Bigrams</i>
In an attempt to give context to his speeches, bigrams (two words bind together) were created. The most frequent topics discussed in group one were: ‘climate change’ (217 repetitions), ‘sustainable development’ (183), ‘human rights’ (116), and ‘climate action’ (86).  In group two, the most frequent words repeated together also include ‘sustainable development’ (127), ‘climate change’ (106), ‘climate action’ (103), and ‘human rights’ (84). These issues continue to be of top priority for the SG pre and post the 74th Session of the UN General Assembly. 

<i>Qudrogram</i>
The SG agenda is consistent throughout. For group one, an increased concern for issues regarding climate change can be seen. However now that ‘more context’ has been added it can be seen he has framed the situation as a call to action. For example, one of the top quadrograms include ‘global issues require global’ action (a very common use phrase in the UN). He frequently repeats ‘issues require global solutions’ or ‘climate change deserve international’, which can be interpreted as a calling for action in the international community. This all makes sense given that he is the SG of the UN, and organization that prides itself on multilateral action and relations.
In this quadrogram one can also see that ‘concerns including gender equality’ are also within his agenda.  Also, he frequently discusses hate speech, anti-Semitism and anti-Muslim feelings. Once you look at the titles and location of some of his speeches, he quite often accepts invitations to speak in commemorations of holocaust survivors and insisting that intolerance is dangerous, indicating a commitment to peace and tolerant societies (UN News , 2019 A; UN News, 2019 B).
In the second group, he emphasizes on the Israeli Palestinian conflict insisting that the ‘Palestinian conflict remains key’, he has said phrases like ‘occupied Palestinian territories including’, what makes one believe that he supports some kind of reconciliation and peace between  Israel and Palestine, and even perhaps some degree of decolonization.
He also mentions that ‘nationalist narrative gain appeal’ and that ‘ethnic nationalist narrative gain’, this call is most likely a reflection of what is been happening in the world: increased nationalist sentiment and ethnic conflicts, from Brexit and Trump’s, Bolsonaro’s and Modi’s presidencies, to the occupation of Palestine, the persecution of minority Muslim groups in Myanmar, China and  Kazakhstan and other religious and ethnic clashes in Africa and the Middle East (The Economist, 2020; Saavedra, 2019; News, 2020; Hughes, 2018; Varshalomidze, 202). The issues discussed in the second group appear to have slightly shifted from climate change issues to human rights concerns. 

<i>3.4 Sentiment analysis</i>
The most frequently positive and negative words used by the SG were analyzed: On the negative side, conflict is at the top of the list in both groups alongside terrorism, hate, violence, attacks, poverty, and extremism among others. This again can be reflected in his bigger discourse. In both groups, positive words include support (most likely from the international community, given what has been analyzed thus far). Words like support, solidarity, sustainable, peace, progress, and commitment, may reflect his commitment to multilateralism (see Figure 4 and Figure 5 for most frequent positive and negative words).

<div align="center">
 
![positive/negative SG1](https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/negative_SG1.png)

Figure 4: UN Secretary General top ten most frequent positive and negative words from speeches dating September 17, 2019 to February 08, 2020 (SG1).

![positive/negative SG2](https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/negative_SG2.png)
 
Figure 5: UN Secretary General top ten most frequent positive and negative words from speeches dating September 17, 2019 to February 08, 2020 (SG 2)

</div>
Moreover, a word cloud was created to evaluate how his words relate to feelings of disgust, anticipation, anger, trust, surprise, sadness, positive, negative, joy and fear. For both groups, it seems that he is quite balanced in his sentiments throughout his speeches with extra emphasis on words that resemble disgust, surprise, and joy (see Figure 6 for group one word cloud). This pattern repeats itself for group two.

<div align="center">
 
![wordcloud](https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/wordcloud_SG.png)
 
Figure 6: UN Secretary-General cloud word sentiment analysis from speeches dating September 17, 2019, to February 08, 2020 (SG1).

</div>

<i>3.5 Visualizing networks between related words </i>
Finally, a network to visualize the relationship among words simultaneously was. Again, the pattern remains much the same. Climate change continues to be a top priority issue for the SG and it is connected with action, summit and security (see Figures 6 and 7). This again is in agreement with what was previously found: firstly that climate is at the top of the SG’s agenda and thus he convened a Summit about it, and secondly that he is framing the issue as one that needs action, particularly international action. This pattern can be seen again in the second group of speeches.

<div align="center">
 
![network SG1](https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/networkSG1.PNG)

Figure 6: UN Secretary-General bigram network analysis from speeches dating September 17, 2019, to February 08, 2020 (SG1) showing only those repetitions over 17 times.

![network SG2](https://github.com/cdchopitea/SG_Speeches_TextAnalytics/blob/master/networkSG2.PNG)
 
Figure 7: UN Secretary-General bigram network analysis from speeches dating September 17, 2019, to February 08, 2020 (SG1) showing only those repetitions over 17 times.

</div>

<i>4.	Conclusions and recommendations </i>
The goal of this assessment was to compare two groups of speeches and understand what issues are in the SG’s agenda and identify if he is now talking about food or food systems, and if he does, how he frames it. And secondly, to compared whether since he agreed to convene the Summit he has discussed the issue of food systems publicly. It can be concluded that the SG has not boosted a public discourse around ‘food systems’ or ‘food’ at all, and a lack of leadership appears throughout.
 Most of his agenda has focused on climate change and human rights with a focus on a call to action to the international community. This is, in fact, problematic since the Food Systems Summit is supposed to take place in a year. If the SG is not taking on this issue it will be very unlikely that heads of state will take the Summit serious, which will result in little action towards improving our broken food systems. 
As a result, the Summit team needs to refocus the SG agenda, that is if they want the Summit to take place at the highest possible level (head of state) and result in concrete actions. For example, to increase the visibility of the food issues and the Summit the SG could take advantage of the upcoming G20, and attempt to inserted food systems in the discussion. As well, the SG could take advantage of the upcoming High-Level Political Forum on Sustainable Development and UN General Assembly to continue building on this issue. 

5.	References
General, U. N. (2019, September 21). Secretary-General's remarks to Youth Climate Summit [as delivered]. UNited Nations. Retrieved from: https://www.un.org/sg/en/content/sg/statement/2019-09-21/secretary-generals-remarks-youth-climate-summit-delivered.
FAO. (2020, February 20). FAO Regional Conference for Asia and the Pacific. From: http://www.fao.org/3/nc131en/nc131en.pdf.
Hertsgaard, M. (18, September 2019). 'We're losing the race': UN secretary general calls climate change an 'emergency'. The Guardian, pp. Retrieved from: https://www.theguardian.com/environment/2019/sep/18/un-secretary-general-climate-crisis-trump.
Hughes, R. (2018, November 8). China Uighurs: All you need to know on Muslim 'crackdown'. BBC News. Retrieved from: https://www.bbc.com/news/world-asia-china-45474279.
News, B. (2020, January 23). Myanmar Rohingya: What you need to know about the crisis. BBC News.  Retrieved from: https://www.bbc.com/news/world-asia-41566561.
Saavedra, B. M. (2019, September 20). Trump, Bolsonaro, Modi: anti-migration, ecocide, and conflict escalation: The agenda of the global right. Open Democracy. Retrieved from: https://www.opendemocracy.net/en/democraciaabierta/trump-bolsonaro-modi-anti-migraci%C3%B3n-ecocidio-y-escalada-de-conflictos-aspectos-en-la-agenda-de-la-derecha-global-en/.
The Economist. (2020, February 3). Brexit and English nationalism. The Economist. Retrieved from: https://www.economist.com/britain/2020/01/30/brexit-and-english-nationalism.
UN News. (2019 A, November 7). Antisemitism, intolerance, can be unlearned, Guterres tells New York commemoration. UN News. Retrieved from: https://news.un.org/en/story/2019/11/1050911.
UN News. (2019 B, October 9). German synagogue shooting ‘another tragic demonstration of antisemitism’: UN chief. UN News. Retrieved from: https://news.un.org/en/story/2019/10/1048901.
United Nations. (2019, December 1). Amid worsening climate crisis, UN Secretary-General sets out top ten climate action priorities for 2020, vows to stay on frontlines. Sustainable Development Goals, p. Retrieved from: https://www.un.org/sustainabledevelopment/blog/2019/12/77358/.
Varshalomidze, T. (202, February 10). Ethnic violence blows hole in Kazakhstan's narrative of tolerance. AlJazeera, pp. https://www.aljazeera.com/news/2020/02/ethnic-violence-blows-hole-kazakhstan-narrative-tolerance-200210091600580.html.

</div>
</hmtl>

