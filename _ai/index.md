---
title: AI
layout: default
permalink: /ai
redirect_from: /ai/index.html
redirect_from: /ai/home
---


# Build and Maintain a Reliable Secure AI Agent in the Cloud

<img src="{{ '/images/ai/agents_working_for_you.png' | relative_url }}" alt="Agentic AI assistants working for you 24×7" class="ai-hero" />

Welcome to the AI series hub. This series provides a comprehensive guide to building, deploying, and maintaining production-ready AI agents in the cloud. Learn how to architect secure, scalable agents using Google ADK, MCP protocol, and cloud-native services like Cloud Run and Firebase.


## Topics

{% assign ai_posts = site.ai | where:"series","Build and Maintain a Reliable Secure AI Agent in the Cloud" | sort:"sequence" %}

<ul>
{% for post in ai_posts %}
  {% assign label = post.sequence | prepend: '1.' %}
  {% if post.status != "draft" %}
    <li>
      {{ label }}:
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {% if post.short_summary %}- {{ post.short_summary }}{% endif %}
    </li>
  {% else %}
    <li>{{ label }}: {{ post.title }} – coming soon…</li>
  {% endif %}
{% endfor %}
</ul>

Stay tuned—new content will drop here as each section is ready.