const { resolve } = require("@sap/cds");
const { action } = require("@sap/cds/lib/core/classes");
const { where } = require("@sap/cds/lib/ql/cds-ql");


module.exports = cds.service.impl( async function () { 
   
    let { EmployeeService } = this.entities;

    let { salesOrderService } = this.entities;

    this.before('UPDATE', EmployeeService, async (request, response) => {

        console.log('Salary Update Request: ', request.data.EmployeeService);
        if (request.data.SALARY > 100000 ) {
            request.error(400, 'Salary cannot be more than 100000');
        }
    })

    this.before('INSERT', EmployeeService, async (request, response) => {
        console.log('Salary Insert Request: ', request.data.SALARY);
        console.log('Currency Insert Request: ', request.data.CURRENCY_code);
        if (request.data.SALARY > 100000 && request.data.CURRENCY_code === 'INR') {
            request.error(400, 'Salary cannot be more than 100000 for INR currency');
        }else if (request.data.SALARY > 10000 && request.data.CURRENCY_code === 'USD') {
            request.error(400, 'Salary cannot be more than 10000 for USD currency');
        }
    })

   this.on('gethighestSalary', async (request, response) => {
        try {
            // Step-3 : Create an object for the transaction
            const tx = cds.tx(request);
 
            // Step-4 : Get salary of an employee using Transaction object
            const response = await tx.read(EmployeeService).columns('SALARY').orderBy({
                SALARY: 'desc'
            }).limit(10);
 
            // Step-5 : Return the response
            return response;
        } catch (error) {
            return "Error : " + error;
        }
    })

    this.on ('CreateEmployee', async (request, response) => {
      try {  
        let dataset = request.data;

        let tx = cds.tx(request);

        let returndata = await tx.run([
            INSERT.into(EmployeeService).entries(dataset)
        ]).then( ( resolve, reject )=> {
                if(typeof(resolve) !== 'undefined') {
                    return request.data;
                } else {
                    request.error(500, 'Error while creating employee');
                }
    }).catch( (error) => {
        request.error(500, "Error in creating employee : " + error);
    })
    return request.data;
    } catch (error) {
         request.error(500, "Error : " + error);
    }
    } )

    this.on('discountPrice', async (request, response) => {
        try {
            const id = request.params[0];
            const tx = cds.tx(request);

            await tx.update(salesOrderService).with({
              
                GROSS_AMOUNT: { '-=': 1000 } ,
                NET_AMOUNT: { '-=': 800 },
                TAX_AMOUNT: { '-=': 200 }

            }).where(id);
            return { message: 'Price discounted successfully' };
        } catch (error) {   
            request.error(500, "Error : " + error);
        }
    } )
} )