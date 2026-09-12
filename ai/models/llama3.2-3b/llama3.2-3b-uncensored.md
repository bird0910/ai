# Llama 3.2 3b Uncensored
---
NoteType:
  - documentation
Application:
  - Ollama
ApplicationCategory:
  - AI
SourcesCited:
  - https://huggingface.co/lemuralabs/Llama-3.2-3B-Uncensored-GGUF?show_file_info=model-Q4_K_M.gguf
tags:
aliases:
---
# Llama-3.2-3b-uncensored

## Basics


| variable          | value                                                                                           |
| ----------------- | ----------------------------------------------------------------------------------------------- |
| full name         | Nidum Llama-3.2-3b-uncensored-gguf-Q4_K_M                                                       |
| url path          | https://huggingface.co/lemuralabs/Llama-3.2-3B-Uncensored-GGUF?show_file_info=model-Q4_K_M.gguf |
| quantization      | 4 bit Q4_K_M                                                                                    |
| size (GB)         | 2.02 GB                                                                                         |
| size (parameters) | 3B                                                                                              |
| base model        | Llama 3.2 3b Instruct                                                                           |
| tags              | chemistry, biology, legal, code, medical...                                                     |
| skills/usage      |                                                                                                 |
| other             |                                                                                                 |

### Intended Purposes
*not yet finished, needs work*

> [!FUNCTIONS]
> - jobs
> - and/or
> - functions for llama
> - purposes.

### Submodel


| Variable       | value |
| -------------- | ----- |
| name           |   null    |
| ModelFile      |  null     |
| ModelFile path |   tbd    |

#### Params

| Parameter | value | notes |
| --------- | ----- | ----- |
| temperature | 0.0 - 2.0 | higher is creative-er |
| top_p | 0.0 - 2.0 | probability of response (next word) |
| top_k | 1-100 | prob. of response (whole, token) |
| repeat_penalty | 0.0 - 2.0 | punishes repeated words |
| presence_penalty | 0.0 - 2.0 | punishes repeated tokens/ideas |
| num_ctx | >= 8192 | is system max, about 6-10 PDF pgs of text |
| num_thread | <= 14 | out of 16 cores, max number to utilize, comment out for RAG/multi-agent setups |
| num_batch | 128 | chunks of text, this is optimal per my hw |
| stop phrase | ex: `<|stop|>` | short phrase or word that makes model stop response immediately to save tokens and minimize repetition/wrong responses. Usually already provided. Don't need if using via GUI |


#### Prompt

System prompt, which I usually write myself, explaining what is expected of it, how to meet expectations, means/ways/limits of finding answers; what to do when it doesn't know, tone of voice to use (if important), code or text-structure of responses (i.e., bullet-points for lists, numbered steps for actions/processes, markdown headings to separate sections, whatever else...) this increases speed.
If jobs are complicated, go through steps of how to successfully complete each one and how to serve/structure response. If citations are required, say so.
Tell it how "creative" to be, if at all, or which prompts from user activate this behavior.
And whatever else...the more details, the better, but remember this uses up tokens too. (I think?)

Besides system prompts (always want these active), there's also optional "job prompts" that can optionally go in modelfiles too, or activated via GUI settings/preferences someimes.


#### Template
*always taken from `/show template` in ollama cli...this one's long AF*,
Isn't really required, ollama usually handles, but consistency helps...


```
{{- if or .System .Tools }}<|start_header_id|>system<|end_header_id|>
{{- if .System }}

{{ .System }}
{{- end }}
{{- if .Tools }}

Cutting Knowledge Date: December 2023

When you receive a tool call response, use the output to format an answer to the orginal user question.

You are a helpful assistant with tool calling capabilities.
{{- end }}<|eot_id|>
{{- end }}
{{- range $i, $_ := .Messages }}
{{- $last := eq (len (slice $.Messages $i)) 1 }}
{{- if eq .Role "user" }}<|start_header_id|>user<|end_header_id|>
{{- if and $.Tools $last }}

Given the following functions, please respond with a JSON for a function call with its proper arguments that best answers the given prompt.

Respond in the format {"name": function name, "parameters": dictionary of argument name and its value}. Do not use variables.

{{ range $.Tools }}
{{- . }}
{{ end }}
Question: {{ .Content }}<|eot_id|>
{{- else }}

{{ .Content }}<|eot_id|>
{{- end }}{{ if $last }}<|start_header_id|>assistant<|end_header_id|>

{{ end }}
{{- else if eq .Role "assistant" }}<|start_header_id|>assistant<|end_header_id|>
{{- if .ToolCalls }}
{{ range .ToolCalls }}
{"name": "{{ .Function.Name }}", "parameters": {{ .Function.Arguments }}}{{ end }}
{{- else }}

{{ .Content }}
{{- end }}{{ if not $last }}<|eot_id|>{{ end }}
{{- else if eq .Role "tool" }}<|start_header_id|>ipython<|end_header_id|>

{{ .Content }}<|eot_id|>{{ if $last }}<|start_header_id|>assistant<|end_header_id|>

{{ end }}
{{- end }}
{{- end }}
```

---
## Official docs

%% copypasta start --> %%

NEED TO GET FROM MODELCARD PAGE

%% <-- end copypasta %%
