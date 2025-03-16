---
layout: page
title: 文章归档
permalink: /archive/
---

{% assign posts_by_year = site.posts | group_by_exp:"post", "post.date | date: '%Y'" %}

{% for year in posts_by_year %}
## {{ year.name }}

{% for post in year.items %}
- {{ post.date | date: "%Y-%m-%d" }} &raquo; [{{ post.title }}]({{ post.url | relative_url }})
{% endfor %}

{% endfor %}