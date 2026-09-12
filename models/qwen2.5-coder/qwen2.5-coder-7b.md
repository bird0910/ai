# Qwen 2.5 Coder 7B
---
NoteType:
  - documentation
Application:
  - Ollama
ApplicationCategory:
  - AI
SourcesCited:
  - "[model card](https://huggingface.co/bartowski/Qwen2.5-Coder-7B-Instruct-abliterated-GGUF)"
tags:
aliases:
---

# Qwen 2.5 Coder 7B

> [!SUBMODELS]
> - qwencode

## Basics



| variable          | value                                                                 |
| ----------------- | --------------------------------------------------------------------- |
| full name         | bartowski/bartowski/Qwen2.5-Coder-7B-Instruct-abliterated-GGUF-Q4_K_M |
| url path          | hugging face                                                          |
| quantization      | Q4_K_M                                                                |
| size (GB)         | 4.7                                                                   |
| size (parameters) | 7.62B                                                                 |
| base model        | Qwen                                                                  |
| architecture      | Qwen2                                                                 |
| context length    | 32768                                                                 |
| embedding length  | 3584                                                                  |
| capabilities      | completion, tools, insert                                             |

### Intended Purposes

> [!FUNCTIONS] 
> - coding
> - python projs
> - bash scripts
> - technical projects (requiring math, programming, etc.)


### Submodel

| Variable       | value                                 |
| -------------- | ------------------------------------- |
| name           | qwencode                              |
| ModelFile      | qwencodeFile                          |
| ModelFile path | ... ai/models/modelfiles/qwencodeFile |

#### Params

| var        | value |
| ---------- | ----- |
| num_ctx    | 8192  |
| num_batch  | 128   |
| num_thread | 13    |
| temp       | 0.1   |
| top_p      | 0.3   |
| top_k      | 30    |
| rep_pen    | 0.2   |
| pres_pen   | 0.1   |

#### Prompts
```text
You are qwencode, specialist in Python packages, bash scripts, and working with Google Colab notebooks and PyCharm. You focus on efficiently automating tasks and generating quality code. Remember that I use tools such as a package manager which works like poetry called 'uv', PyCharm as an IDE, and sometimes Jupyter Notebooks, and implement solutions with and through these tools whenever possible. Also always remember that I use and code for linux systems at all times, specifically Arch-based distributions, and require answers to be focused around this at all times appropriate.
Your top priorities are accuracy and clarity! When unsure about requirements or context, ALWAYS ask for clarification FIRST instead of making assumptions and providing an answer which may be incorrect or irrelevant. ALWAYS VERIFY FIRST. If you are incorrect about something, and the user informs you of this, DO NOT forget this context in all future responses!
Favor modular design in Python applications, breaking them down into reusable functions and classes. Implement logging to track program execution and facilitate debugging. Whenever logical, use the src implementation for package structural design (root/project directory structure) and ALWAYS INCLUDE a pyproject.toml in standalone application builds - assume CLI applications should always be standalone that run as executables. 
At the same time, try to keep any scripts, applications, and packages as simplistic and uncomplicated as possible. Utilize highly efficient solutions and code to create compact and effective final products.
If you make a mistake, acknowledge it immediately and provide the corrected code. Do not forget this correction, and use it as context for future responses.
```


#### Template
Taken directly from `/show template`:
```ollama
{{- if .Suffix }}<|fim_prefix|>{{ .Prompt }}<|fim_suffix|>{{ .Suffix }}<|fim_middle|>  
{{- else if .Messages }}  
{{- if or .System .Tools }}<|im_start|>system  
{{- if .System }}  
{{ .System }}  
{{- end }}  
{{- if .Tools }}  
  
# Tools  
  
You may call one or more functions to assist with the user query.  
  
You are provided with function signatures within <tools></tools> XML tags:  
<tools>  
{{- range .Tools }}  
{"type": "function", "function": {{ .Function }}}  
{{- end }}  
</tools>  
  
For each function call, return a json object with function name and arguments within <tool_call></tool_call> XML tags:  
<tool_call>  
{"name": <function-name>, "arguments": <args-json-object>}  
</tool_call>  
{{- end }}<|im_end|>  
{{ end }}  
{{- range $i, $_ := .Messages }}  
{{- $last := eq (len (slice $.Messages $i)) 1 -}}  
{{- if eq .Role "user" }}<|im_start|>user  
{{ .Content }}<|im_end|>  
{{ else if eq .Role "assistant" }}<|im_start|>assistant  
{{ if .Content }}{{ .Content }}  
{{- else if .ToolCalls }}<tool_call>  
{{ range .ToolCalls }}{"name": "{{ .Function.Name }}", "arguments": {{ .Function.Arguments }}}  
{{ end }}</tool_call>  
{{- end }}{{ if not $last }}<|im_end|>  
{{ end }}  
{{- else if eq .Role "tool" }}<|im_start|>user  
<tool_response>  
{{ .Content }}  
</tool_response><|im_end|>  
{{ end }}  
{{- if and (ne .Role "assistant") $last }}<|im_start|>assistant  
{{ end }}  
{{- end }}  
{{- else }}  
{{- if .System }}<|im_start|>system  
{{ .System }}<|im_end|>  
{{ end }}{{ if .Prompt }}<|im_start|>user  
{{ .Prompt }}<|im_end|>  
{{ end }}<|im_start|>assistant  
{{ end }}{{ .Response }}{{ if .Response }}<|im_end|>{{ end }}
```


---

## Documentation
%% from modelcard copypasta start --> %%

### Prompt Format

```text
<|im_start|>system
{system_prompt}<|im_end|>
<|im_start|>user
{prompt}<|im_end|>
<|im_start|>assistant
```

%% <-- end copypasta %%
