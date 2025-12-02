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

<style>
  .topics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 1.5rem;
    margin: 2rem 0;
  }

  .topic-card {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    padding: 1.5rem;
    transition: all 0.3s ease;
    text-decoration: none;
    color: inherit;
    display: block;
    position: relative;
    overflow: hidden;
  }

  .topic-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 4px;
    height: 100%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    transform: scaleY(0);
    transition: transform 0.3s ease;
  }

  .topic-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    border-color: #667eea;
    text-decoration: none;
    color: inherit;
  }

  .topic-card:hover::before {
    transform: scaleY(1);
  }

  .topic-card.draft {
    opacity: 0.6;
    cursor: not-allowed;
  }

  .topic-card.draft:hover {
    transform: none;
    box-shadow: none;
  }

  .topic-number {
    display: inline-block;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    width: 2rem;
    height: 2rem;
    border-radius: 50%;
    text-align: center;
    line-height: 2rem;
    font-weight: 600;
    font-size: 0.875rem;
    margin-bottom: 1rem;
  }

  .topic-card.draft .topic-number {
    background: #9ca3af;
  }

  .topic-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 0.75rem;
    line-height: 1.4;
  }

  .topic-card:hover .topic-title {
    color: #667eea;
  }

  .topic-summary {
    color: #6b7280;
    font-size: 0.9375rem;
    line-height: 1.6;
    margin: 0;
  }

  .topic-status {
    display: inline-block;
    margin-top: 0.75rem;
    padding: 0.25rem 0.75rem;
    background: #f3f4f6;
    color: #6b7280;
    border-radius: 20px;
    font-size: 0.8125rem;
    font-weight: 500;
  }

  @media (max-width: 768px) {
    .topics-grid {
      grid-template-columns: 1fr;
      gap: 1rem;
    }
  }
</style>

{% assign ai_posts = site.ai | where:"series","Build and Maintain a Reliable Secure AI Agent in the Cloud" | sort:"sequence" %}

<div class="topics-grid">
{% for post in ai_posts %}
  {% assign label = post.sequence | prepend: '1.' %}
  {% if post.status != "draft" %}
    <a href="{{ post.url | relative_url }}" class="topic-card">
      <div class="topic-number">{{ post.sequence }}</div>
      <h3 class="topic-title">{{ post.title }}</h3>
      {% if post.short_summary %}
        <p class="topic-summary">{{ post.short_summary }}</p>
      {% endif %}
    </a>
  {% else %}
    <div class="topic-card draft">
      <div class="topic-number">{{ post.sequence }}</div>
      <h3 class="topic-title">{{ post.title }}</h3>
      <span class="topic-status">Coming soon</span>
    </div>
  {% endif %}
{% endfor %}
</div>

<p class="text-muted mt-4" style="text-align: center;">Stay tuned—new content will drop here as each section is ready.</p>