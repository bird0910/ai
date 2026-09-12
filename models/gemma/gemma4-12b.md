# gemma-4-12B
---
NoteType:
  - documentation
Application:
  - Ollama
ApplicationCategory:
  - AI
SourcesCited:
  - "[official modelcard](https://huggingface.co/mradermacher/gemma-4-12B-it-abliterated-uncensored-GGUF?show_file_info=gemma-4-12B-it-abliterated-uncensored.Q4_K_M.gguf)"
tags:
  - OLLAMA
  - local
  - ai
  - models
  - modelfile
  - GGUF
  - HuggingFace
  - 4BitQuantization
  - abliterated
  - Uncensored
aliases:
---
# gemma-4-12B

## Basics

| variable          | value                                                                                                                                           |
| ----------------- | --------------------------------- |
| full name         | gemma-4-12b-it-abliterated-uncensored.Q4_K_M.gguf         |
| url path          | https://huggingface.co/mradermacher/gemma-4-12B-it-abliterated-uncensored-GGUF?show_file_info=gemma-4-12B-it-abliterated-uncensored.Q4_K_M.gguf |
| quantization      | Q4_K_M  |
| size (GB)         | 7.38 GB |
| size (parameters) | 12B |
| base model        | gemma4 |
| tags              | gemma, gegma4, unified, abliterated...  |
| modalities        | text, image, audio (encoder-free/unified)  |
| sample top_p      | 0.949999 |
| sample top_k      | 64  |
| sample temp       | 1.0  |
| gen ctx_length    | 131072   |
| embed_len         | 3840 |
| base model        | https://huggingface.co/OpenYourMind/gemma-4-12B-it-abliterated-uncensored  |

### Intended purposes

> [!FUNCTIONS]
> - tbd
> - undecided

### Submodel

| Variable       | value |
| -------------- | ----- |
| name           | ?      |
| ModelFile      |  tbd     |
| ModelFile path |     ?  |

#### Parameters

| Param name | value | explanation |
| ---------- | ----- | ----------  |
| num_ctx    | up to 8k | is all my hw can stand |
| num_thread | up to 14 | leaving SWAP some cores to function |
| num_batch | 128 | optimal number for my hw |
| temperature | 0.0 - 2.0 | higher means more creative, lower is more logic |
| top_p | 0.0 - 2.0 | higher means greater probability of response, less random |
| top_k | 1-100 | calculates probability of response by whole tokens; number is the max of likeliest tokens |
| repeat_penalty | 0.0 - 2.0 | higher means less repetition of words and more randomness |
| presence_penalty | 0.0 - 2.0 | higher means less repeated tokens and more novelty in ideas |

#### Prompt
Sometimes docs specify a specific system prompt for best usage; probably not for gemma...must write own.

#### Template
ask `/show template` in ollama for specs.

---

## Online Docs
*source: [modelcard](https://huggingface.co/OpenYourMind/gemma-4-12B-it-abliterated-uncensored).*

### Overview
%% begin copypasta -->%%


Full BF16 weights of **gemma-4-12B-it-abliterated-uncensored** — an abliterated, uncensored variant of [google/gemma-4-12B-it](https://huggingface.co/google/gemma-4-12B-it) (Gemma 4 12B Unified, dense, ~11.95B parameters). The model keeps Gemma 4's encoder-free **unified multimodal** stack intact — text, image, and audio inputs flow straight into a single decoder-only transformer — so this checkpoint is a drop-in replacement for the original instruction-tuned model at the architecture level.

The pipeline:

1. **Refusal Ablation** — Residual-stream refusal directions (one per decoder layer) were extracted via diff-in-means on a labeled harmful/harmless prompt set and baked into the weights as a per-matrix delta on the residual-write modules, using our own custom abliteration framework.
2. **Multimodal Preservation** — Gemma 4 12B is encoder-free: image patches and audio waveforms are projected directly into the embedding space, so there is no separate vision/audio tower to graft back. Tensor names, shapes, and the `config.json` schema (`Gemma4UnifiedForConditionalGeneration`, `model_type: gemma4_unified`) match the base model exactly — this checkpoint loads anywhere the original loads.

#### Key properties

- Uncensored across the standard refusal axes
- Reasoning preserved (configurable thinking mode — see Best Practices)
- Multimodal: text + image + audio carried forward
- Drop-in shape compatibility with `google/gemma-4-12B-it`

#### Best properties

- **Sampling:** `temperature=1.0`, `top_p=0.95`, `top_k=64` (the values shipped in `generation_config.json`).
- **Thinking mode:** enabled by setting `enable_thinking=True` in `apply_chat_template`; the processor's `parse_response` separates the reasoning block from the final answer. Do not feed previous-turn thoughts back into multi-turn history.

%% <-- copypasta end %%
