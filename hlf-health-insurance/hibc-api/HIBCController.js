var express = require('express');
var router = express.Router();
var bodyParser = require('body-parser');

router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.json());

var HIBC = require("./FabricHelper")


// Request LC
router.post('/requestClaim', function (req, res) {

    HIBC.requestClaim(req, res);

});

// Issue LC
router.post('/processClaim', function (req, res) {

    HIBC.processClaim(req, res);
    
});

// Accept LC
router.post('/approveClaim', function (req, res) {

    HIBC.approveClaim(req, res);
    
});

// Get LC
router.post('/getClaimStatus', function (req, res) {

    HIBC.getClaimStatus(req, res);
    
});

// Get LC history
router.post('/getClaimHistory', function (req, res) {

    HIBC.getClaimHistory(req, res);
    
});


module.exports = router;
