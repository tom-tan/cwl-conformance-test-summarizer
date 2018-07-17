# cwl-conformance-test-summarizer

This tool summarize the result of [cwltest](https://github.com/common-workflow-language/cwltest) to make the badge using [shields.io](https://shields.io).

Requirements:
- Ruby 2.5.0 or later

Example:
```console
$ pip install cwltest # necessary to run the conformance test
$ pip install cwltool # example of the workflow engine
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

Once you store the output of this tool in a server that can be accessed via internet,
you can use the badge of the result of conformance test by using the following links, for example:

```
![CWL conformance](https://img.shields.io/badge/dynamic/json.svg?label=CWL%20conformance&query=$.ratio&colorB=green&suffix=%&uri=https://raw.githubusercontent.com/tom-tan/cwl-conformance-test-summarizer/master/sample-summary.json&style=flat)
```

Here is the results:

![CWL conformance](https://img.shields.io/badge/dynamic/json.svg?label=CWL%20conformance&query=$.ratio&colorB=green&suffix=%&uri=https://raw.githubusercontent.com/tom-tan/cwl-conformance-test-summarizer/master/sample-summary.json&style=flat)

## Todo and Known Issues:
- The badge color should reflect the result. For example, green when all the tests passed, orange when all the tests for required features passed, and red when some tests for required feature failed.
  - Currently shields.io does not support dynamic setting for colors. Once [#1525 for badges/shields](https://github.com/badges/shields/pull/1525) is merged, we will use badges that reflect the results.
- I cannot see the badge for the above example...
  - Dynamic badge generation in shields.io takes a little time and browsers sometimes fail to get the badge due to timeout.
