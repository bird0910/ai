---
NoteType: info
parent:
  - ai
SourcesCited:
  - Google search, reddit
Application: Jan AI, Ollama
tags:
  - ai
  - agents
  - models
  - HuggingFace
  - LLMs
  - local
  - OLLAMA
  - PDFs
  - projects
  - RAG
---

# Model Recommendations

According to Gemini (google search), running Ollama models on 8 cores with 16GB ram (this laptop)...
> "You can comfortably run 7B-14B parameter models using ollama, specifically quantized versions (q4_k_m or q5_k_m).
> Mistral 7B, Llama 3.2 8B, Gemma3 12B and Qwen3 14B offer the best balance of speed and intelligence...smooth  interactions while leaving enough memory for the OS.

## Basic Recommended Models (16GB RAM)
- **Qwen3 14B/Qwen 2.5 7B**:
    - **14B version**: Provides the best instruction-following and balance of speed for interactive use.
    - **7B version**: Excellent for programming and debugging, with a peak RAM usage of around 6.4GB, allowing it to run alongside other heavy apps.
- **Llama 3.1 8B**:
    - A versatile "workhorse" model that fits easily into 8GB of allocated RAM. It is highly efficient for general tasks and has a standard 128k context window.
- **Mistral Small 24B (Quantized)**:
    - While a 24B model is large, highly quantized versions (like IQ4_XS or Q4_K_L) can fit under 15GB. It offers superior language quality but may be slower on a CPU-only setup.
- **Gemma 3 12B / 9B**:
    - **12B version**: Promising for reasoning and general use on modest hardware.
    - **9B version**: Great for content creation and complex reasoning, typically using about 7+ GB of RAM.
- **Phi-4 (14B)**:
    - Microsoft's latest "small but powerful" model, specifically optimized for strong reasoning tasks while remaining lightweight enough for 16GB systems.


### Performance Tips
- **Quantization**: Always look for `q4_K_M` or similar 4-bit quantized versions. These reduce memory needs by ~50% with minimal loss in "intelligence".
- **Limit Context**: Reducing the context window (e.g., to 4096 or 8192) significantly lowers RAM usage for the KV cache.
- **Resource Management**: Close heavy applications like web browsers (Chrome) when running 14B+ models to avoid swapping to the disk, which will severely slow down the response.

## Use Case: Scientific Research, Hypothesis Generation
For researching science-based topics and generating hypotheses on a 16GB RAM system,

==**Phi-4 (14B)** and **Qwen 2.5 (14B)**== are your strongest options. Scientific reasoning requires a model that can handle complex logical steps and maintain "instruction following" without hallucinating relationships between variables.

### Top Recommendation: Phi-4 (14B)

Phi-4 is specifically engineered for high-level reasoning and scientific tasks.

- **Why it's best for science**: It performs exceptionally well on reasoning benchmarks that mimic scientific problem-solving. It is designed to be "small but smart," making it ideal for the memory constraints of a 16GB system.
- **Hypothesis Generation**: It excels at taking a set of observations and proposing testable, [falsifiable](https://pmc.ncbi.nlm.nih.gov/articles/PMC12534748/) statements based on established theory.

### Second Choice: Qwen 2.5 (14B)

If your research involves a lot of data or cross-disciplinary information, Qwen 2.5 is a powerful alternative.

- **Knowledge Breadth**: It has a vast training corpus that includes significant amounts of technical and scientific literature, making it a great "research assistant" for exploring existing studies.
- **Logical Deductions**: It is highly effective at [deductive reasoning](https://en.wikipedia.org/wiki/Scientific_method), which is essential for moving from general principles to specific predictions.

### How to Use Them for Hypotheses

To get the most "science-focused" output, try using the **PICOT approach** (Population, Intervention, Comparison, Outcome, Time) in your prompts to help the model structure a [testable hypothesis](https://u.osu.edu/qmc/research-qs-and-hypotheses/). 

|Feature|Phi-4 (14B)|Qwen 2.5 (14B)|
|---|---|---|
|**Primary Strength**|Pure reasoning & logic|General scientific knowledge|
|**RAM Usage (Q4)**|~9-10 GB|~9-10 GB|
|**Speed on 8 Cores**|Moderate|Moderate|
|**Context Window**|Good for deep logic|Better for long papers|

**Pro Tip:** Since you have 16GB of RAM, look for the **Q4_K_M** (4-bit) quantization of these models. This will allow the model to fit in about 10GB of RAM, leaving 6GB for your OS and any [scientific modeling software](https://study.com/learn/lesson/scientific-models.html) or research papers you have open.

## Most Popular: Top Ollama RAG Models 2026
- **Best General & Enterprise RAG:** **Granite3.3 (8b)** (Efficient, strong RAG performance).
- **Best Long-Context RAG:** **Mistral Nemo (12b)** (128k context window for large documents).
- **Best Small/Local Model:** **Phi-3 Mini (3.8b)** (Fast, efficient, strong reasoning for its size).
- **Best High-Performance:** **Gemma 2 (27b)** (High-quality, low-hallucination, good for detailed, accurate answers).
- **Best Reasoning/Advanced RAG:** **DeepSeek-R1** (Highly capable for complex reasoning tasks).

### Top Embedding Models for RAG
For the retrieval part of RAG, these embedding models (which turn text into searchable vectors) are recommended within Ollama: 

- **[bge-m3](https://www.google.com/search?client=firefox-b-1-d&q=bge-m3&sei=FyTRaYiBH7iWkPIPlbab8AI&mstk=AUtExfBrTUKOOgDhLcOSoV5PtEgig2a4b7KJmc-PH7Ok1rJp2qtTiuhv-9In8ig-e9kVJjekshBHCxNQMXi-QBggRg4AMzFGrjvCtsodvvkh5J-8BiIEZz1QeJQKKroJj9zhwhA&csui=3&ved=2ahUKEwjy_r7ot9STAxW-LEQIHdl3IksQgK4QegQIBhAB)**: Offers top-tier, multi-lingual, and high-performance embedding capability.
- **[mxbai-embed-large](https://www.google.com/search?client=firefox-b-1-d&q=mxbai-embed-large&sei=FyTRaYiBH7iWkPIPlbab8AI&mstk=AUtExfBrTUKOOgDhLcOSoV5PtEgig2a4b7KJmc-PH7Ok1rJp2qtTiuhv-9In8ig-e9kVJjekshBHCxNQMXi-QBggRg4AMzFGrjvCtsodvvkh5J-8BiIEZz1QeJQKKroJj9zhwhA&csui=3&ved=2ahUKEwjy_r7ot9STAxW-LEQIHdl3IksQgK4QegQIBhAD)**: Strong all-around performer with high-quality embeddings.
- **[nomic-embed-text](https://www.google.com/search?client=firefox-b-1-d&q=nomic-embed-text&sei=FyTRaYiBH7iWkPIPlbab8AI&mstk=AUtExfBrTUKOOgDhLcOSoV5PtEgig2a4b7KJmc-PH7Ok1rJp2qtTiuhv-9In8ig-e9kVJjekshBHCxNQMXi-QBggRg4AMzFGrjvCtsodvvkh5J-8BiIEZz1QeJQKKroJj9zhwhA&csui=3&ved=2ahUKEwjy_r7ot9STAxW-LEQIHdl3IksQgK4QegQIBhAF)**: Excellent for long-context tasks.

### Tips for RAG with Ollama
- **Context Window:** Ensure your chosen model has a large enough context window (2048+ tokens) to hold the prompt and retrieved documents.
- **Embeddings:** Use `bge-m3` for better retrieval performance if you have the resources, or `nomic-embed-text` for speed.
- **Reranking:** Implement a reranker (e.g., `BAAI/bge-reranker-v2-m3`) after retrieving chunks to improve the quality of the top results.

## See Also
[The Complete Guide to LLM Fine-Tuning](file:///home/bird/downloads/Qwopus3-5-27b-Colab_complete_guide_to_llm_finetuning.pdf) <-- also found locally in the man/ dir.
And also summarized locally 


---

## Use Case: Text to Speech
For making audiobooks out of ebooks?

Recommendations from a [reddit post](https://www.reddit.com/r/LocalLLaMA/comments/1mfjn88/tts_model_comparisons_my_personal_rankings_so_far/) by someone with a Lenovo Legion 4090; he likes to use CLI only.

##### **Bark/Coqui TTS -**
- **The Good:** The emotions are next level... kinda. At least they have it, is the main thing. What I've done is create a custom Llama model, that knows when to send a [laughs], [sighs], etc. that's appropriate, given the conversation. The custom ollama model is pretty good at this (if you're curious how to do this as well you can create a basefile and a modelfile). And it sounds somewhat human. But at least it can somewhat mimic human emotions a little, which many cannot.
- **The Bad:** It's pretty slow. Sometimes takes up to 30 seconds to a minute which is pretty undoable, given I want my robot to have fluid conversation. I will note that none of them are able to do it seconds or less, sadly, via CLI, but one was for UI. It also "trails off", if that makes sense. Meaning - the ollama may produce a text, and the Bark/Coqui TTS does not always follow it accurately. I'm using a custom voice model as well, and the cloning, although sometimes okay, can and does switch between male and female characters, and doesn't sometimes even follow the cloned voice. However, when it does, it's somewhat decent. But given how it often does not, it's not really too usable.
        
##### **F5 TTS -**
- **The Good:** Extremely consistent voice cloning, from the UI and CLI. I will say that the UI is a bit faster than using CLI, however, it still takes about 8 seconds or so to get a response even with the UI, which is faster than Bark/Coqui, but still not fast enough, for my uses at least. Honestly, the voice cloning alone is very impressive. I'd say it's better than Bark/Coqui, except that Bark/Coqui has the ability to laugh, sigh, etc. But if you value consistent voicing, that's close to and can rival ElevenLabs without paying, this is a great option. Even with the CLI it doesn't trail off. It will finish speaking until the text from my custom ollama model is done being spoken.
- **The Bad:** As mentioned, it can take about 8-10 seconds for the UI, but longer for the CLI. I'd say it's about 15 seconds (on average) for the CLI and up to 30 seconds (for about 1.75 minutes of speech) for the CLI, or so depending on how long the text is. The problem is can't do emotions (like laughing, etc) at all. And when I try to use an exclamation mark, it changes the voice quite a bit, where it almost doesn't sound like the same person. If you prompt your ollama model to not use exclamations, it does fine though. It's pretty good, but not perfect.
        
##### **Orpheus TTS**
- **The Good:** This one can also do laughing, yawning, etc. and it's decent at it. But not as good as Coqui/Bark. Although it's still better than what most offer, since it has the ability at all. There's a decent amount of tone in the voice, enough to keep it from sounding too robotic. The voices, although not cloneable, are a lot more consistent than Bark/Coqui, however. They never really deviate like Bark/Coqui did. It also reads all of the text as well and doesn't trail off.
- **The Bad:** This one is a pain to set up, at least if you try to go the normal route, via CLI. I've only been able to set it up via Docker, actually, unfortunately. Even in the UI, it takes quite a bit of time to generate text. I'd say about 1 second per 1 second of speech. There also times where certain tags (like yawning) doesn't get picked up, and it just says "yawn", instead. Coqui didn't really seem to do that, unless it was a tag that was unrecognizable (sometimes my custom ollama model would generate non-available tags on accident).
        
##### **Kokoro TTS**
- **The Good:** Man, the UI is blazing FAST. If I had to guess about ~ 1 second or so. And that's using 2-3 sentences. For a about 4 minutes of speech, it takes about 4 seconds to generate text, which although isn't perfect, it's probably as good as it gets and really quick. So about 1 second per 1 minute of speech. Pretty impressive! It also doesn't trail off and reads all the speech too, which is nice.
- **The Bad:** It sounds a little bland. Some of the models, even if they don't have explicit emotion tags, still have tone, and this model is lacking there imo. It sounds too robotic to me, and doesn't distinct between exclamation, or questions, much. It's not terrible, but sounds like an average Speech to Text, that you'd find on an average book reader, for example. Also doesn't offer native voice cloning, that I'm aware of at least, but I could be wrong.
        
##### **Higgs Audio TTS**
- **The Good:** The really neat thing about Higgs audio is that it doesn't have preset voices that you choose from, but rather, you prompt in how you want the voice to sound. At least from their example. It's surprisingly consistent as well. Through multiple generations, while maintaining the same voice speaker prompt, the voice stays relatively the same. The emotions sound bland at first, but you can prompt in speakers to have more tone to their voices. I used a speaker that has tone similar the main girl from legally blonde, since she has a lot of tone and emotion in her voice.
- **The Bad:** No voice cloning. Although it is somewhat offset by it's ability to prompt in voices, you still can't clone voices. Personally, I'd say the worst thing is how long it takes to generate a prompt. I only had about 10 seconds of audio, but it took about a minute to generate. And I tried for about 20 seconds of audio and it took about 2 minutes to generate. It seems like for every 1 second of audio, it takes about 6 seconds to generate, which is quite a bit of time. However, if you value the ability to prompt in voices, it's a decent choice.
        
##### **Chatterbox TTS**
- **The Good:** This one also has the ability to clone voices. It does it very well too. Sounds just like the speaker I based it off of. Probably one of the best at voice cloning. I'd say it rivals ElevenLabs. The tone is pretty decent and consistent, and doesn't sound too robotic, which is nice too.
-  **The Bad:** It takes about 1.5 seconds of generation time for every 1 second of audio generated. If you're only generating 5 seconds of audio, it'll result in about 8 seconds of generation time, however, if you want 30 seconds of audio, it will take quite a while to generate (45 seconds). 15 seconds of audio took 22 seconds to generate. Although the tone is decent it has trouble with exclamation specifically. But I've noticed a few do.
        
##### **Kyutai TTS**
 - **The Good:** Emotions and tone are fantastic. One of the best ones for sure. Although it doesn't support laughing, sighing, etc, the tone in the voice makes up for it. It definitely sounds close to human. If I had to describe this model, I'd say it's very expressive!
- **The Bad:** Takes about .75 seconds of generation time for 1 second of audio. Better than some, but still not ideal. Especially for longer lengths of dialogue. Although it's supposed to be able to support voice cloning, their open source model does not seem to offer this ability unfortunately. It would almost be worth creating your own safetensors model because of how expressive it, then figuring out where in the repo to replace it though.
        
##### **Dia TTS**
- **The Good:** Has the most emotion tags that I've seen on a TTS model. I tried it out a few and it's pretty good (at least sometimes). It offers voice cloning as well, which is always a plus to me. The voice cloning does take some effort, but it can get close. I'd say it also tapers off as the audio goes on, but mostly recognizable from the original speaker. Also the BEST part about it is it's expressiveness. It's quite insane how realistic it is.
- **The Bad:** This can be a huge PAIN to setup, and I do mean that. At least if you want to try the GPU version. To save you some troubles, do NOT try and run it with pip, gradio, or cli from the repo... They do not work sadly I've tried all 3. Others have mentioned that in the comments here as well: https://www.youtube.com/watch?v=o6C3sWc2T3c Anyways, I did try it with "uv", and it seems to be working, but it's still EXTREMELY slow. 120 seconds of generation time for 10 seconds of audio... About 12 seconds of generation time for 1 second of audio, this has been very consistent for me unfortunately. And I'm using a 4090 Laptop... Anyways, if you don't want to deal with the GPU setting up, this means you'll have to use CPU version which is very very slow, didn't even care to measure CPU times, mainly because I forgot it was running it took so long lol. It's theoretically supposed to support GPU, but natively it does not that well (if someone gets this figured out, please let me know). They claim 1 second of generation time for 1 second of audio, but I've gotten nowhere close to that, and neither did they in the video I linked above. The other thing to note is that although there's a lot of emotion tags, the voice cloning isn't that great. If you clone a female voice, it'll sound female, but not exactly like the speaker - it will deviate (unlike F5 or ElevenLabs - the two best I'd say so far). I even tried with longer audio input as well (until I had too much input, and it wouldn't run). As mentioned above, it can sound recognizable to the cloned voice, but it's not SOTA or even close - it doesn't always. You also have to provide a text transcription of the audio too for input. It's not terrible, but a little annoying, if you don't have it on hand pasted somewhere. If you don't you'll have to google search for some free transcriptions (that don't pop up a paywall JUST before you get the transcription...) or type it out manually. In my opinion, if they got some of the other emotion tags working better (some can interfere with the rest of the prompt and lead to some oddities) and sped up generation time quite a bit (for the local available to us version), while keeping a more consistent cloned voice, this has a LOT of potential. Just not quite there yet. Anyways, I could critique the other models similarly.
        
##### **OpenVoice TTS**
- **The Good:** The voice cloning is decent, but not perfect. It has the ability to change tone, for example, it can do cheerful, whispering, sad, etc. Generation time isn't the fastest, but not the slowest either. Almost 1.4 seconds of generation time for 1 second of audio.
 - **The Bad:** It sounds pretty bland, and lacks expression. Pretty monotone in my opinion. As mentioned, voice cloning isn't SOTA either. It gets the general sound of the voice close, but it's not exact, and you can tell. If you want very close voice cloning, I'd say there's better out there. Although 1.4:1 isn't terrible, if you're trying to generate longer audio, it'll take awhile, which doesn't work for me. It severely lacks expression as well. It does have "sad", "whispering", etc. but no laughs, gasps, etc. It just gives a general tone for the sentence, paragraph, or whatnot, and sounds pretty bland, in my opinion, and whether you use "whispering", "terrified", etc. there's not a whole of difference between them, where it really matters.
        
##### **Qwen3 TTS**
- **The Good:** The voice cloning is good! It's not perfect, but almost as good as F5 and Eleven Labs, although those two have the clear edge. It has voice prompting too, which I've found is decent. You can prompt things like tone and gender of the speaker which I've found to be okay. If you decide to prompt in a speaker, I was somewhat impressed by how if you choose a yelling tone, for parts of the sentence that should be calm, they are. Whereas I thought they would still be yelling.
- The Bad: It doesn't seem like there's many different options when choosing specific voices themselves for the gender. For example, whether you choose middle aged or old, the voices don't change much. Tone is where it excels at. It's supposed to support laughing and other emotions, but doesn't seem to. From my experience it mainly excels for tones. I would say Higgs Audio is better in this regard. It also does take awhile to generate audio. I'd say about 3 seconds for 1 second of audio.


### Google's Recommendations
When I inquired of google how to set up a TTS ai model to create audiobooks

---

## Use Case: Pairing with PyCharm as a Plugin for Code Generation, README generation, refactoring help, and more

See plugin "MyOllamaEnhancer" for more details about the plugin (as well as local (README) documentation: [[MyOllamaEnhancer]].

### Recommended
According to the official README, reasoning models work best.

> [!LIST]
> - `llama3:8b-instruct-q6_K`
> - `deepseek-r1:8b-llama-distill-q8_0`


#### Reddit
Best local AI Models for Coding in PyCharm

##### Model Choices and Tradeoffs

- **Qwen 3.6 27B (coding quality)**: Good balance of coding ability and reasoning; higher quality for debugging/refactoring but can be slow and needs more VRAM. ["Qwen 3.6 27B is current peak of the pyramid I think."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovk8ccs/)
    
- **Qwen 3.6 35B A3B (speed + good punch)**: Often recommended when GPU VRAM is limited because the A3B/MoE layout can be faster and lighter on GPU while retaining strong coding capability. ["qwen3.6 35b a3b and it's doing great."](https://www.reddit.com/r/LocalLLM/comments/1uua97m/comment/ox23feu/)
    
- **Smaller coder models (7B/14B) for responsiveness**: Use 7B–14B coder variants if you need interactive speed inside an editor. ["If you want something usable locally, stick to smaller, optimized models like Qwen2.5-Coder (7B/14B) or DeepSeek-Coder 6–7B. They're much more responsive..."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovnqrt8/)
    
- **DeepSeek / Cohere North Mini Code (alternatives)**: Viable on more modest hardware; Cohere North Mini Code reported as fast and competent for code tasks at Q4 on a 4090. ["I've been using Cohere North Mini Code ... It's very fast - getting approx 200tk/s ... It's very fast - getting approx 200tk/s - and very competent."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovpjm5w/)



##### Quantization, Offloading & Performance Tips

- **Use quantization (Q4/Q5/FP8) when VRAM is limited**: Run models in quantized formats to fit in GPU memory and improve speed. ["Qwen 3.6 27B. Run at least fp8 if you can."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovmclxa/)
    
- **A3B / MoE helps smaller GPUs by offloading**: MoE/A3B variants let part of the model live off-GPU to fit bigger models on smaller cards. ["Its an MoE models ... its like splitting the library and knowledge and it can live in different place like CPU hence the name A3B..."](https://www.reddit.com/r/LocalLLaMA/comments/1tmhypf/comment/onn5slh/)
    
- **Expect slower prefill with offload; tune caching**: Prefill/prompt processing can be the bottleneck when using offload; caching/prefix strategies help. ["The thing I'd flip in your framing: ... prompt processing on offload is much slower, which is exactly what bites you when you feed in existing code...."](https://www.reddit.com/r/LocalLLM/comments/1ugks5y/comment/ou2wy51/)
    
- **Use FP16/KV cache considerations for agentic coding**: Quantising the KV cache or using FP16 can affect model correctness — test with FP16 or Q8 if possible. ["I've noticed quantisation of the kv cache seriously impairs some models. Try with FP16 or Q8 if you can."](https://www.reddit.com/r/LocalLLM/comments/1uua97m/comment/ox20vtt/)

##### Editor Integration & Agent/Harness Choices for PyCharm

- **Use lightweight local harnesses for editor workflows**: Tools like OpenCode, Pi, or llama.cpp-backed servers integrate well with coding flows and reduce tool-loop problems vs some heavier agents. ["Use OpenCode for free tiers, if you want to play and learn pay on OpenRouter for some models."](https://www.reddit.com/r/ollama/comments/1uqw3ow/comment/owbd9bp/)
    
- **Pi agent + tuned extensions for stability**: Pi with extensions can reduce looping and tool-call failures when driving local models in agents. ["I'm using Pi with an extension I wrote that works around the occasional looping and tool call failures..."](https://www.reddit.com/r/LocalLLM/comments/1uua97m/comment/ox24wt1/)
    
- **Avoid overly agentic workflows if hardware is limited**: Agent mode amplifies latency; local models excel at autocomplete, refactors and explanations inside an editor, but multi-step agent loops can be slow. ["Local coding models are good for autocomplete, simple refactors, explanations, and offline work but once you move into agent mode, they get slow fast unless you have serious GPU power."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovnqrt8/)


##### Practical Setup Recommendations for PyCharm
- **If you have decent GPU VRAM (>=24GB)**: Consider Qwen3.6 27B for best coding quality; run fp8/q4 and a harness like vLLM/LLama.cpp or OpenCode for editor integration. ["Unless you have an ungodly amount of vram, the rough 'standard' is qwen 3.6 27B..."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovmdpi7/)
    
- **If you have moderate VRAM (8–16GB)**: Qwen3.6 35B A3B at Q4/Q5 or a 14B coder with partial offload is a practical tradeoff for PyCharm use. ["Qwen3.6 35B A3B... best mix of performance and quality if GPU has less than ~ 20-24GB VRAM."](https://www.reddit.com/r/ollama/comments/1u1gy7r/comment/oqpnpsm/)
    
- **If you have low VRAM (≤8GB)**: Use 7B coder models or specialized small models (DeepSeek 6–7B, Cohere North Mini Code, or VibeThinker-3B for one-off scripts) and accept limited context. ["Qwen2.5 7B is trash ... So I recommend Qwen3.6 35B A3B on Q4. ... Offloading into system ram is fine..."](https://www.reddit.com/r/LocalLLM/comments/1ugks5y/comment/ou0ttoo/) / ["For once-off scripts try VibeThinker-3B."](https://www.reddit.com/r/LocalLLM/comments/1ugks5y/comment/ouqzecx/)
    
- **Tune prompts & provide skeletons**: For complex logic, give the model explicit distributions, loop skeletons, or function stubs to improve correctness. ["The other half is that 'not good for my specific logic' is usually a prompt problem more than a model-size one."](https://www.reddit.com/r/LocalLLM/comments/1ugks5y/comment/ou2wy51/)
    
- **Monitor prefill/throughput and enable prefix caching**: Use prefix caching and avoid workflows that invalidate KV cache (e.g., injecting long file lists into the system prompt). ["Pi and oh-my-pi on Mac are really good about not disrupting the prefix cache... It’s a huge unlock."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovqc70s/) / ["I have been using OMLX, but with OpenCode. It seems it alters the system prompt with a list of files and that basically invalidates the entire chain."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovseqrq/)

##### Contrarian/Reality Check POVs

- **Cloud may be simpler and faster for heavy/agentic coding**: Many recommend using cloud models for agent workflows instead of fighting local limits. ["If your priority is strong agent behavior and speed, GPT/Claude/Gemini are still clearly ahead."](https://www.reddit.com/r/ollama/comments/1unhfca/comment/ovnqrt8/)
    
- **Sometimes local is not worth the cost/complexity on small hardware**: For small laptops or 4GB VRAM systems, local models may be impractical — use cloud or OpenCode. ["None of them, get an ollama cloud subscription"](https://www.reddit.com/r/ollama/comments/1uqw3ow/comment/owb7xgo/) and ["You cannot do anything useful with 8gb vram and 16gb ram."](https://www.reddit.com/r/LocalLLM/comments/1ugks5y/comment/ou32cz4/)

##### Subreddit Links
- [r/ollama](https://www.reddit.com/r/ollama/)
- [r/LocalLLM](https://www.reddit.com/r/LocalLLM/)
- [r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/)


