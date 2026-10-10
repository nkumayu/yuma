---
layout: page
title: Publications
permalink: /publications/
description: Papers and research outputs.
nav: true
nav_order: 2
---

{% capture bibliography_content %}{% bibliography %}{% endcapture %}
{% assign bibliography_text = bibliography_content | strip_html | strip %}
{% if bibliography_text != '' %}
{% include bib_search.liquid %}
  <div class="publications">{{ bibliography_content }}</div>
{% else %}
  <div class="empty-publications">
    <span class="eyebrow">Publication record</span>
    <h2>No publications at present.</h2>
    <p>There are currently no papers to list here. This page will be updated when publications become available.</p>
    <a class="text-link" href="{{ '/research/' | relative_url }}">Read about my research interests <span aria-hidden="true">→</span></a>
  </div>
{% endif %}
