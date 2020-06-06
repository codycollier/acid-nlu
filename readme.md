# acid-nlu

A collection of intent datasets for natural language understanding

* status: This is an alpha stage project
* pace: The pace of progress is leisurely


## Overview

Acid-nlu is an aggregation and normalization of datasets related to intent classification.

Intent classification is an area of machine learning and natural lanuage understanding, often associated with conversational agents, chatbots, and dialogue systems. Such systems accept text spoken or typed by a user, and attempt to classify the desired intent of the user, so that subsequent responses and/or processing can take place. Related tasks might include classification of a secondary subintent, identifying "slots" for an intent, and performing named entity recognition (NER) on the text.

There are several freely available datasets in this realm, but they are all structured and organized differently.  The primary aim of this project is to aggregate and normalize the respective datasets, and provide a common interface for using them to build, train, and evaluate NLU / NLP models.


## The processed data

The processed data is available in a single csv file just under 6MB in size.

```
$du -sh ./data/alldata.csv
5.7M	./data/alldata.csv
```

See the following for some basic information about the processed dataset, including lists of intents and utterance counts:

* [dataset information](dataset-info.md)


## Original data sources

Acid-nlu aggregates pre-existing datasets from other sources.  See the link below for attribution and information about the original sources including links to repositories, associated papers, citation information, and licenses.

* [original dataset sources](dataset-sources.md)



