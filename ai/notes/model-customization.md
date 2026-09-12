# Model Customization
---
NoteType: documentation
DocsCategory: Models
parent:
  - ai
aliases:
  - temperature
  - top_p
  - top_k
  - logit_bias
  - stream
  - repeat_per
  - frequency penalty
  - presence penalty
tags:
  - ai
  - agents
  - parameters
  - models
  - optimization
  - BestPractice
  - debugging
  - LLMs
  - prompts
  - training
  - troubleshooting
SourcesCited:
  - https://aviralrma.medium.com/understanding-llm-parameters-c2db4b07f0ee
  - https://www.google.com/url?sa=i&source=web&rct=j&url=https://www.youtube.com/watch?v%3DCPs_PGELoMY&opi=89978449&psig=AOvVaw1TD4Mmnj0wp0AAO2H_Dmbt&ust=1775404096314000
---
# Model customization

## Basics

> [!KEY] 
> The default storage path for Ollama to save/store models is either or both:
> 1. `/usr/share/ollama/.ollama`
> 2. `/var/lib/ollama` <-- <mark style="background: #FFB8EBA6;">This is the default for arch systems</mark>
> 3. `~/.ollama`
> However, if you want to change where the models live, you can edit the environment variable in .bashrc:
> `export OLLAMA_MODELS=/home/bird/.ai/models/`
> Remember, though,  the ollama.service file sets this variable directly in-file; need to edit this one first as it takes precedence over .bashrc, etc.

#### Assigning a modelfile
When finished editing the modelfile, assign it to a model like this:
`ollama create $MODELNAME -f Modelfile`



## How to set up a MODELFILE

### Format: template
```text
# modelfile for NAME--uses of this model
# Base model:
# example: FROM qwen2.5-coder:7b-instruct-q4_K_M
FROM nameOfbaseModel:latest

############## Performance parameters start ###############
# Set context value to 6-10pgs of text - this is about minimum
PARAMETER num_ctx 8192
# Processes chunks of text faster as per my hw limitations:
PARAMETER num_batch 128
# Set temp: logical - creative; 0.0 - 1.0
PARAMETER temperature 0.5
# Set number of cores to use, remember SWAP! Teams=comment this out.
PARAMETER num_threads 13
# Higher value keeps focus on hi-probability responses: 0.0 - 1.0
PARAMETER top_p 0.9
# Much like above param, different measure (see docs)
PARAMETER top_k 20
# Punishes repetitive words - higher means bigger vocab 0.0 - 2.0
PARAMETER repeat_penalty 1.5
# Punishes whole repeated tokens - higher means more novelty 0 - 2.0
PARAMETER presence_penalty 1.3
# Sets max token length (incl words + punct) for brevity
PARAMETER length 150
# The emergency stfu phrase
PARAMETER stop_sequence "<|STFU|>"

##################### Prompts Section ##############################
# The system prompt introduces the model, tells its main job/purpose,
# and gives outlines of specific dos and don'ts.
SYSTEM """
put prompt here.
"""

# Standard template (under `/info template`) - Ollama usually handles
# this automatically, but explicitly defining it here ensures
# better stability. Simple example:
TEMPLATE """
<start_of_turn>user
{{ .Prompt }}<end_of_turn>
<start_of_turn>model
{{ .Response }}<end_of_turn>
"""
```

For specific examples, see my old ModelFile examples at [main ai dir](/home/bird/.ai). They are the files without extensions that end in 'File,' like 'WriterFile'.

### Setting Parameters

| Name             | Description                                                                                                                                                                                                                                          | Range   |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| temperature      | **PREDICTABLE - CREATIVE**. Controls randomness of output. Low values mean determinism, focus, accuracy; high values mean randomness and creativity.                                                                                                 | 0.0-2.0 |
| top_p            | Augments vocabulary size: limits the pool of potential next words to a subset of the most likely options. **Lower value makes the output more focused/deterministic/probable**; **higher values give a larger vocabulary size, randomizing output.** | 0.0-1.0 |
| top_k            | Limits the next word selection to the top K most likely options                                                                                                                                                                                      |         |
| max_tokens       | Limits the maximum size of response, including words and punctuation                                                                                                                                                                                 |         |
| repeat_penalty   | Limits words by how often they've already appeared; higher values mean less repetition                                                                                                                                                               | 0.0-2.0 |
| presence_penalty | Punishes tokens which have already appeared. The higher the value, the greater encouragement to explore new topics.                                                                                                                                  | 0.0-2.0 |
| stop sequence    | String of characters to cause immediate shutting up; keeps answers precise                                                                                                                                                                           | STRING  |

#### Parameter details

##### Temperature
>"_According to OpenAI API spec, this controls randomness. Lower value means more predictable output while higher allow for more creativity. The value is between 0 and 2_...As a side note, I like to remember this by the analogy that a hotheaded (read higher temperature) person can say anything, so can an LLM."

<mark style="background: #FF5582A6;">Range 0.0-2.0</mark>
Controls 'creativity.' Low values mean determinism, focus, accuracy; high values mean more randomness and creativity.

##### top_p
>"controls the model output by augmenting the vocabulary size as only those tokens are considered for ==which the cumulative probability is greater than the top_p value=="

<mark style="background: #FF5582A6;">*close to 1 (e.g. 0.95</mark>)* A large portion of vocabulary is fair game, which makes the output more random.
<mark style="background: #FF5582A6;">*close to 0 (e.g. 0.1)*</mark> Only those tokens with the highest probability are considered, so the output is considered more deterministic (predictable).
<mark style="background: #FF5582A6;">*range 0.0-1.0*</mark> Limits the pool of potential next words to a subset of  the most likely options; lower value makes output more focused.

##### top_k
Similar to top_p as it reduces vocabulary size; however, instead of cumulative probability it works by reducing the vocabulary size to top k tokens (sorted in descending order by their respective probabilities).
Limits the next word selection to the top K most likely options.
accepts INTEGER (1-100[^1]?)

##### logit_bias
>"Modify the likelihood of specified tokens appearing in the completion.  
Accepts a json object that maps tokens (specified by their token ID in the tokenizer) to an associated bias value from -100 to 100. Mathematically, the bias is added to the logits generated by the model prior to sampling. The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token."[^2]

##### Max Tokens (or Length)
Sets max length of output, including words and punctuation.
Accepts INTEGER

##### Repeat Penalty
<mark style="background: #FF5582A6;">Range 0.0-2.0</mark>
Punishes words based on how often they've already appeared; higher values reduce repetitiveness.

##### Presence Penalty
<mark style="background: #FF5582A6;">Range 0.0-2.0</mark>
Punishes tokens which have already appeared, encouraging exploration of new topics the higher the number.

##### Stop Sequences
A string of characters that causes the model to immediately stop outputting; useful for keeping output concise.
accepts STRING


### Quick Tuning Guidelines by Use Case

| Task             | Temperature | top_p   | Penalties          |
| ---------------- | ----------- | ------- | ------------------ |
| Code/Math        | 0.0-0.2     | 0.1-0.5 | Low/None (0.1-0.3) |
| Factual Q & A    | 0.1-0.4     | 0.7-0.9 | Low (0.3-0.5)      |
| Summarization    | 0.3-0.5     | 0.8-1.0 | Low (0.5-0.7)      |
| Creative Writing | 0.8-1.5     | 0.9-1.0 | Moderate (1.3-1.5) |
| Brainstorming    | 1.0-1.5     | 1.0     | High (1.5-2.0)     |

#### Specific Examples
> [!CAUTION] 
> I wrote these out myself and have yet to test them - so take with fistful of salt and use at own risk.

##### Researcher/Summarizer
- Wants: No hallucinating, pedantic accuracy.
- Params: 
	- Low repeat_penalty,
	- low-moderate presence_penalty, 
	- low temperature, 
	- moderate top_p and/or top_k

##### General Knowledge/connection maker/idea generator
- Wants: Big context. A tiny bit of hallucinating is ok in lieu of hightened creativity, but still highly accurate. Responsible for making connections (big picture), drawing conclusions, forming hypotheses, finding new areas of study.
- Params:
	- Large context and cores utilized
	- Mod repeat penalty
	- Mod-high presence penalty
	- Mid-hi temperature
	- High top_p

##### Technical Writer
- Params:
	- Low-mod temperature
	- Moderate top_p
	- Moderate penalties


##### Creative Writer
This section ==needs fixing ==
- Params:
	- Mod-hi temp
	- low-med top_p
	- higher top_k
	- larger context size, cores
	- mod repeat penalty (1.3-1.5)
	- mod-hi presence penalty (1.5)



### Troubleshooting common bad behaviors

- <mark style="background: #FFB86CA6;">Hallucinations</mark>: Reduce temperature to 0.0-0.3 and reduce top_p to 0.7-0.8
- <mark style="background: #FFB86CA6;">Repetitive Loops</mark>: Increase repeat penalty 0.3-0.8 or Presence Penalty to 0.1-0.6
- <mark style="background: #FFB86CA6;">Too Random</mark>: Reduce temperature and set a fixed seed

---

## Coming up with prompts
See also - I wrote up some stuff on this topic already[^4]
According to people on reddit, this is maybe the most important part of a ModelFile.
	Fortunately, I don't have to do much thinking about this, because Hugging Face happens to have a really cool prompt generator tool[^3] that holds your hand for this stuff. No more making chatGPT write my prompts!

There are several different (optional) prompts one could use. For most cases, it seems to me that a SYSTEM prompt is enough to suffice for most uses.

### System prompt

#### Outline (suggested)
> [!KEY] 
> Words highlighted in <mark style="background: #CACFD9A6;">GREY</mark> should be edited to specifications/preferences.


##### Paragraph 1
You are <mark style="background: #CACFD9A6;">NAME</mark>, a <mark style="background: #CACFD9A6;">JOB-TITLE</mark> who specializes in <mark style="background: #CACFD9A6;">SPECIFIC USE CASE/S</mark>. You focus on <mark style="background: #CACFD9A6;">ACTION</mark> and maintaining accuracy and quality in your responses. You are aware of my<mark style="background: #CACFD9A6;"> TOOLS/PROGRAMS/LANGUAGES</mark> I commonly use, so you should implement these tools into solutions whenever possible.

##### Paragraph 2
Your top priorities are <mark style="background: #CACFD9A6;">BLANK</mark> and <mark style="background: #CACFD9A6;">BLANK</mark>. When unsure about requirements or context, ALWAYS ask for clarification FIRST instead of making assumptions and providing an answer which may be incorrect or irrelevant. ALWAYS VERIFY FIRST. <mark style="background: #CACFD9A6;">Extra details about specific uses.</mark>

##### Rules and Directions: Lists
Strict Rules:
1. Citations: Every claim you make must be followed by a citation from the text (e.g., "The study found X [Section 3.2, Page 5]").
2. Integrity: If the answer is not explicitly stated in the provided text, state: "The provided document does not contain this information." Do not use outside knowledge.
3. Formatting: Use Markdown headers for different sections and bullet points for data extraction.
4. Tone: Maintain a tone appropriate to your <mark style="background: #CACFD9A6;">USE</mark> as a <mark style="background: #CACFD9A6;">JOB-TITLE</mark> - i.e., utilize a tone which is <mark style="background: #CACFD9A6;">ADJECTIVE, ADJECTIVE</mark> and <mark style="background: #CACFD9A6;">ADJECTIVE</mark> at all times.
5. Summarization: When asked to summarize, outline, or paraphrase, always provide a <mark style="background: #CACFD9A6;">"Key Findings"</mark> list and a <mark style="background: #CACFD9A6;">"Methodology"</mark> overview first.

Directives for other use case, e.g., <mark style="background: #CACFD9A6;">when planning projects</mark>:
1. Identify high-impact topics and sub-topics for a given subject, while always mindfully integrating user suggestions as a central focus.
2. Create hierarchical outlines with logical flow and transitions.
3. Suggest<mark style="background: #CACFD9A6;"> research directions</mark> or <mark style="background: #CACFD9A6;">key arguments</mark> for each section.
4. When asked to do so, <mark style="background: #CACFD9A6;">use a big-picture perspective to make connections between topics and ideas. Volunteer testable theories and hypotheses that would deepen understanding and spark new methods and modes of topics to research and variables to experiment upon.</mark>
5. Maintain a <mark style="background: #CACFD9A6;">professional, clear, and highly organized</mark> tone.


##### Last line: one-off, occasional responsibilities
For <mark style="background: #CACFD9A6;">quick Q&A sessions about the provided context or your general knowledge</mark>, provide direct and factual answers unless the user explicitly requests more creativity, speculation, or novelty in your response. When creativity is desired, the user will say something like, "this query requires less factual thinking and more creativity in your response," or "I challenge you to be as creative as possible when responding," or "I'm less interested in the facts and want to hear your more speculative and creative ideas."



---

## Footnotes



[^1]: Check on this - needs more research/==citation==.

[^2]: NEEDS MORE CLARIFICATION/RESEARCH. Also, ==citation when done.==

[^3]: URL is https://huggingface.co/spaces/baconnier/prompt-plus-plus

[^4]: Links: [[Prompt Engineering]] and also [[AI Jobs]].

