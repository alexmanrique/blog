---
layout: single
title: "Create a bot for Slack using Apps Script without a server"
date: 2024-04-01 09:08:53 +0200
categories: automation
comments: true
lang: en
tags: slack, app script 
image: images/inmutable.jpg
---

In our team we have a role that is called Flow facilitator. This role is in charge to run the daily meeting everyday where we review the Jira Board to detect any blockers that stop the team to deliver. 

How to chose this role every week? In order to avoid any extra work and to spark a little bit of fun every week, we decided to create a **Facilitator Bot** to do this task for us. We agreed that the features the bot must have were the following:

- Automatize the work we were doing by hand, keeping the google sheet up to date
- Notify the whole team about the new selection for the next week
- Execute automatically once a week
- Having fun somehow

But there is a constraint that had to be meet that was very important. We didn't have a dedicated server to host this, and we weren't expecting to have any.

### **Then how?**

At this point is were Google Sheets comes into play. We discovered that Google sheets has a functionality that allows you to attach some Javascript code into your sheet. So that was the answer, we could keep the original sheet and have some magical Javascript code that will execute and will update the facilitators selection and the team counters.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/google-script.png)
{: refdef}

We thought that the language would be Javascript, but it wasn't 100% like that. Despite being almost the same as Javascript, Google has added some code in order to interact with the sheet the script is embedded into. It's a little bit challenging because these Google Sheet integrations have little to no documentation.

So in the end, the script was doing exactly the same as we were doing manually with some change:

- Iterate over the meetings columns
- Per each meeting we select those team members with the minimum count.
- If the list of team members has a size bigger than 1, select **randomly** a team member instead of selecting them by order.
- Update the counters.

### **Who or what is going to run this?**

One important feature of the bot is that it should trigger an execution automatically, but how and when? The when was quite easy to answer, we made a poll inside the team and the result was that people preferred to be notified on Monday's around 9AM. Ok, but how are we going to do that? Luckily the script editor has a tool to trigger executions of the current script.

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/trigger-google-script.png)
{: refdef}

{:refdef: style="text-align: center;"}
![dist files]({{ site.baseurl }}/images/trigger-execution.png)
{: refdef}

**Did you get your role for next week?**

There's still one part missing. We agreed that the bot must notify the team with the new selection made for the upcoming week. Our first and simplistic approach was to send an email every time the script runs. The mail will contain the selection per each week plus a gif in order to make it a little bit more fun to read.

Another approach we could use is to send an slack message every time the script runs and take advantage of all the cool features slack has. We can use webhooks in slack, and we could connect the slack private channel to our script, so that when the script runs the webhook will trigger and show the message.

Every selected team member is mentioned so he or she will get notified when the message is received in the channel. Also there is a link to the Google Sheet that contains all the counters and info of the meetings, in case any member of the team wants to check the "randomness" of the bot.

**Final thoughts**

We had quite few expectations about this bot, but by now and I know it may sound weird, the bot has become part of the team process. Everyone is expecting Mondays's message and takes seriously their role, every team member, from UXers to developers passing by PM's, knows how to use our tools and what are our main KPI's.


