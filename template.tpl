___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Grow - Order Customer ID",
  "categories": ["ATTRIBUTION", "MARKETING", "PERSONALIZATION", "REMARKETING", "CONVERSIONS"],
  "description": "Captures the customer ID from the data layer",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "customerID",
    "displayName": "Customer ID - Optional",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');
const queryPermission = require('queryPermission');
const copyFromDataLayer = require('copyFromDataLayer');

const rawKey = data.customerID;
if (rawKey === undefined) return undefined;

const dlKey = rawKey.trim();
if (dlKey === '') return undefined;

if (queryPermission('read_data_layer', dlKey)) {
  const dlContents = copyFromDataLayer(dlKey);
  return dlContents;
} else {
  log('you dont have permission to read', dlKey);
  return false;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Returns customerID from DL
  code: |-
    const mockData = {
      customerID: 'id'
    };

    mock('copyFromDataLayer', function (key) {
      const map = {
            id: 5,
            ordesadasrID: 2
          };
      return map[key];
    });

    const res = runCode(mockData);
    assertThat(res).isEqualTo(5);
- name: Returns undefined if customerID is not set
  code: |-
    const mockData = {
    };

    mock('copyFromDataLayer', function (key) {
      const map = {
            id: 5,
            ordesadasrID: 2
          };
      return map[key];
    });

    const res = runCode(mockData);
    assertThat(res).isEqualTo(undefined);
- name: Returns undefined if customerID is empty
  code: |-
    const mockData = {
       customerID: ''
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(undefined);


___NOTES___

Created on 11/04/2024, 14:09:54


