# cwl-conformance-test-summarizer

This tool summarize the result of [cwltest](https://github.com/common-workflow-language/cwltest) to make the badge using [shields.io](https://shields.io).

Requirements:
- Ruby 2.5.0 or later

Example:
```console
$ git clone git@github.com:common-workflow-language/common-workflow-language.git
$ cd common-workflow-language
# By default it uses cwltool. For other engines, use ./run_test.sh RUNNER=/path/to/your/favorite/engine
$ ./run_test.sh --junit-xml=results.xml
$ cwl-conformance-test-summarizer.rb v1.0/results.xml | jq .
{
  "success": 130,
  "success_required": null,
  "nall": 132,
  "nrequired": 39,
  "ratio": 98.5,
  "status": "red"
}
```
