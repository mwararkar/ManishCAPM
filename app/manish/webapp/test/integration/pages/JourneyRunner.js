sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"manish/test/integration/pages/salesOrderServiceList.gen",
	"manish/test/integration/pages/salesOrderServiceObjectPage.gen",
	"manish/test/integration/pages/SalesItemServiceObjectPage.gen"
], function (JourneyRunner, salesOrderServiceListGenerated, salesOrderServiceObjectPageGenerated, SalesItemServiceObjectPageGenerated) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('manish') + '/test/flp.html#app-preview',
        pages: {
			onThesalesOrderServiceListGenerated: salesOrderServiceListGenerated,
			onThesalesOrderServiceObjectPageGenerated: salesOrderServiceObjectPageGenerated,
			onTheSalesItemServiceObjectPageGenerated: SalesItemServiceObjectPageGenerated
        },
        async: true
    });

    return runner;
});

