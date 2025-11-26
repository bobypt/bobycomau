---
title: AI
layout: default
permalink: /ai
redirect_from: /ai/index.html
redirect_from: /ai/home
---


# Agentic AI

<img src="{{ '/diagrams/ai/agents_working_for_you.png' | relative_url }}" alt="Agentic AI assistants working for you 24×7" class="ai-hero" />

Welcome to the AI series hub. We focus on simple, autonomous, secure, and practical agents running in the cloud, working for you 24×7—including a hands-on guide to deploy, scale, and observe these agents reliably in production.



## Planned topics

{% assign ai_posts = site.ai | where:"series","Agentic AI Foundations" | sort:"sequence" %}

<ul>
{% for post in ai_posts %}
  {% if post.status != "draft" %}
    <li>
      {{ post.sequence }}:
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {% if post.short_summary %}- {{ post.short_summary }}{% endif %}
    </li>
  {% else %}
    <li>{{ post.sequence }}: {{ post.title }} – coming soon…</li>
  {% endif %}
{% endfor %}
</ul>

Stay tuned—new content will drop here as each section is ready.