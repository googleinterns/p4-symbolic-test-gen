import sys
import json

def sdiff(actual, expected, path):
  try:
    if expected is None and (
        actual == 0 or actual == "" or actual == False or \
        actual is None or actual == [] or actual == {}
    ):  # equate default values to None
      return (True, "")

    if type(actual) != type(expected):
      return (False, path)

    if isinstance(actual, list):
      if len(actual) != len(expected):
        return (False, path)

      for i in range(len(actual)):
        status, rpath = sdiff(actual[i], expected[i], "%s/%d" % (path, i))
        if not status:
          return (False, rpath)

      return (True, "")

    if isinstance(actual, dict):
      for k in actual.keys():
        status, rpath = sdiff(actual[k], expected.get(k, None), "%s/%s" % (path, str(k)))
        if not status:
          return (False, rpath)

      return (True, "")

    return (actual == expected, path)
  except Exception as exp:
    return (False, "%s EXCEPTION %s" % (path, str(exp)))

if __name__ == "__main__":
  expectedFilePath = sys.argv[1]
  with open(expectedFilePath) as expectedFile:
    actual = json.load(sys.stdin)
    expected = json.load(expectedFile)

  status, path = sdiff(actual, expected, "")
  if not status:
    sys.exit("not subset diff! Error at path \"%s\"" % path)