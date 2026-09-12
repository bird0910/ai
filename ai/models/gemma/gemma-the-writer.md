# gemma the writer
---
NoteType:
    - documentation
Application:
    - Ollama
ApplicationCategory:
    - AI
SourcesCited:
    - "[official modelcard](https://huggingface.co/mradermacher/Gemma-The-Writer-9B-HERETIC-Uncensored-Abliterated-GGUF?show_file_info=Gemma-The-Writer-9B-HERETIC-Uncensored-Abliterated.Q4_K_M.gguf)"
tags:
    - gemma
    - 4BitQuantization
    - Uncensored
    - heretic
    - Writing
    - abliterated
    - creative
    - LLMs
aliases:
---
# Gemma THE WRITER

> [!SUBMODELS]
> - [x] ~~gemmastory~~ [[gemma the writer#Creative Writing]]
> - [x] ~~gemmaproofer~~  [[gemma the writer#Proofreader]]
> - gemmatek [[gemma the writer#Technical Writing]] (still needs to be 'created')

## Basics
| variable | value |
| -------- | ----- |
| full name         | gemma The Writer 9B HERETIC Uncensored Abliterated                                                                                                                        |
| url path          | https://huggingface.co/mradermacher/Gemma-The-Writer-9B-HERETIC-Uncensored-Abliterated-GGUF?show_file_info=Gemma-The-Writer-9B-HERETIC-Uncensored-Abliterated.Q4_K_M.gguf |
| quantization      | 4 bit Q4_K_M                                                                                                                                                              |
| size (GB)         | 5.76                                                                                                                                                                      |
| size (parameters) | 9.24B                                                                                                                                                                     |
| base model        | gemma2                                                                                                                                                                    |
| tags              | heretic, uncensored, decensored, abliterated, finetune...                                                                                                                 |
| skills/usage      | "Great for content creation and complex reasoning, typically using about 7+ GB of RAM." - ChatGPT                                                                         |
| context length    | 8192                                                                                                                                                                      |
| embedding length  | 3584                                                                                                                                                                      |
| capabilities      | completion                                                                                                                                                                |
|                   |                                           |

### Intended Purposes

> [!FUNCTIONS] 
> - creative writing
> - content generation
> - character development
> - synonyms, word play, etc.
> - development of plotlines
> - story coherence
> - etc.


### Submodel

#### Creative Writing
| Variable       | value                                             |
| -------------- | ------------------------------------------------- |
| name           | gemmastory                                        |
| ModelFile      | gemmastoryFile                                    |
| ModelFile path | ~/proj/coding/ai/models/modelfiles/gemmastoryFile |

##### Parameters
Predefined (from `/show parameters`:
- `stop` | `"<start_of_turn>"`
- `stop` | `"<end_of_turn>"`

| param            | value |
| ---------------- | ----- |
| num_ctx          | 8192  |
| num_batch        | 128   |
| num_thread       | 12    |
| temperature      | 1.0   |
| top_p            | 0.9   |
| top_k            | 80    |
| repeat_penalty   | 1.5   |
| presence_penalty | 1.5   |

##### Prompt

##### Template
Taken straight from `/show template` in ollama.
```
{{- range $i, $_ := .Messages }}
{{- $last := eq (len (slice $.Messages $i)) 1 }}
{{- if or (eq .Role "user") (eq .Role "system) }}<stat_of_turn>user
{{ .Content }}<end_of_turn>
{{ if $last }}<start_of_turn>model
{{ end }}
{{- else if eq .Role "assistant" }}<start_of_turn>model
{{ .Content }}{{ if not $last }}<end_of_turn>
{{ end }}
{{- end }}
{{- end }}
```

#### Proofreader

| Variable       | value                                               |
| -------------- | --------------------------------------------------- |
| name           | gemmaproofer                                        |
| ModelFile      | gemmaprooferFile                                    |
| ModelFile path | ~/proj/coding/ai/models/modelfiles/gemmaprooferFile |

##### Parameters
Predefined (from `/show parameters`:
- `stop` | `"<start_of_turn>"`
- `stop` | `"<end_of_turn>"`

| param            | value |
| ---------------- | ----- |
| num_ctx          | 8192  |
| num_batch        | 128   |
| num_thread       | 12    |
| temperature      | 0.5   |
| top_p            | 1.4   |
| top_k            | 40    |
| repeat_penalty   | 1.0   |
| presence_penalty | 1.0   |

##### Prompt
```text
Your name is gemmaproofer, and you are an expert proofreader and editor for all forms of writing. Your job consists of proofreading and revising text files which have been chunked into many parts for your review. These text files represent raw extractions of text from PDF files, so they will require more or less post-processing to correct scrambled sentences, words which have been split between lines, remnants of headers and footers, and more.

Your tasks:
1. Revise the text provided, paying special attention to proper sentence structure, readability, and clarity.
2. Search for phrases which don't belong or are out-of-order, either deleting or re-arranging words among nearby lines to re-construct proper, intelligible phrases and sentences.
3. Removal of all title pages, copyright pages, table of contents, acknowledgements, and other front matter.
4. Removal of "headers and footers" which are leftovers from when the text was in another format (such as PDF pages). These include titles, chapter names, and page numbers.
5. Output a revised version of the original document in plaintext form.
6. If chapter markers exist, do not remove these but assign them to their own newline and treat them as a sentence.
   
It is up to you to clean up and render these problematic extractions intelligible before they will be converted into audiobooks. It is of utmost importance that your final output be understandable and coherent, while remaining as faithful to the author's intended meaning as possible!
```

##### Template
Taken straight from `/show template` in ollama.
```
{{- range $i, $_ := .Messages }}
{{- $last := eq (len (slice $.Messages $i)) 1 }}
{{- if or (eq .Role "user") (eq .Role "system) }}<stat_of_turn>user
{{ .Content }}<end_of_turn>
{{ if $last }}<start_of_turn>model
{{ end }}
{{- else if eq .Role "assistant" }}<start_of_turn>model
{{ .Content }}{{ if not $last }}<end_of_turn>
{{ end }}
{{- end }}
{{- end }}
```

#### Technical Writing
*Still needs to be 'created' and modelfile made) - not done yet*

| var            | value                                    |
| -------------- | ---------------------------------------- |
| name           | gemmatek                                 |
| ModelFile      | gemmatekFile                             |
| ModelFile path | ~/proj/ai/models/modelfiles/gemmatekFile |

##### Parameters

| variable         | value |
| ---------------- | ----- |
| temperature      | 0.3   |
| top_p            | 1.1   |
| top_k            | 40    |
| repeat_penalty   | 0.9   |
| presence_penalty | 1.0   |
| num_ctx          | 8192  |
| num_thread       | 10    |
| num_batch        | 128   |

##### Prompt

*not yet written - tbd. Use the form bookmarked in waterfox toolbar @ huggingface.co for auto-generation?*


##### Template
*same as submodel sisters...*
Taken straight from `/show template` in ollama cli..(retyped, beware of typos...):
```
{{- range $i, $_ := .Messages }}
{{- $last := eq (len (slice $.Messages $i)) 1 }}
{{- if or (eq .Role "user") (eq. .RRole "system") }}<start_of_turn>user
{{ .Content }}<end_of_turn>
{{ if $last }}<start_of_turn>model
{{ end }}
{{- else if eq .Role "assistant" }}<start_of_turn>model
{{ .Content }}{{ if not $last }}<end_of_turn>
{{ end }}
{{- end }}
{{- end }}
```

---

## Official docs (modelcard)
%% begin copypasta -->%%

### Options
- If using GGUFs you need to use "llama_HF" (which involves downloading some config files {see /GGUF-auxillary subdir} from the SOURCE version of this model).
    - Source versions (and assoc. config files) of my models are located at: [this huggingface collection](https://huggingface.co/collections/DavidAU/d-au-source-files-for-gguf-exl2-awq-gptq-hqq-etc-etc-66b55cb8ba25f914cbf210be).

**_OTHER OPTIONS_**:
- Increase repeat_pen to 1.1-1.15 (don't need to do this if you use 'smoothing factor')
- If the interace/program you are using to run ai models supports "Quadratic Sampling" (i.e., 'smoothing') just make the adjustment as needed.

### Highest Quality Settings/Optimal operation guide/params and samplers
This is a "class 1" model.
For all settings used for this model (including specifics for its "class"), including example generation(s) and for advanced settings guide (which many times addresses any model issue(s)), including methods to improve model performance for all use case(s) as well as chat, roleplay and other use case(s) please see:
[https://huggingface.co/DavidAU/Maximizing-Model-Performance-All-Quants-Types-And-Full-Precision-by-Samplers_Parameters](https://huggingface.co/DavidAU/Maximizing-Model-Performance-All-Quants-Types-And-Full-Precision-by-Samplers_Parameters)

You can see all parameters used for generation, in addition to advanced parameters and samplers to get the most out of this model here:
[https://huggingface.co/DavidAU/Maximizing-Model-Performance-All-Quants-Types-And-Full-Precision-by-Samplers_Parameters](https://huggingface.co/DavidAU/Maximizing-Model-Performance-All-Quants-Types-And-Full-Precision-by-Samplers_Parameters)

#### Help, Adjustments, Samplers, Params and More

**CHANGE THE NUMBER OF ACTIVE EXPERTS:**
See this document:
[https://huggingface.co/DavidAU/How-To-Set-and-Manage-MOE-Mix-of-Experts-Model-Activation-of-Experts](https://huggingface.co/DavidAU/How-To-Set-and-Manage-MOE-Mix-of-Experts-Model-Activation-of-Experts)

%% <-- end copypasta %%
