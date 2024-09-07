import http from 'http';
import { ElasticLoadBalancingV2Client, DescribeLoadBalancersCommand } from "@aws-sdk/client-elastic-load-balancing-v2";

	var loadbalancer_url_dinamic = '';
	export const handler = async (event) => {
	const config = {
	  region: 'us-east-1'
	};

	const elbv2 = new ElasticLoadBalancingV2Client(config);
    try {
        const command_elb = new DescribeLoadBalancersCommand();
        const client_elb = new ElasticLoadBalancingV2Client(config);
        const response_elb = await client_elb.send(command_elb);
        console.log(response_elb.LoadBalancers[0].DNSName);
		    loadbalancer_url_dinamic = response_elb.LoadBalancers[0].DNSName;
	  	  //loadbalancer_url_dinamic = 'petstore.execute-api.us-east-1.amazonaws.com';
		
    		const postData = JSON.stringify({
          'msg': '',
        });
        
        const options = {
          hostname: `${loadbalancer_url_dinamic}`,
          port: 80,
          path: '/pedidos/historico/arquivarPedidos/1',
          //path: '/petstore/pets',
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Content-Length': Buffer.byteLength(postData),
          },
        };
		
		
    		const response = await new Promise((resolve, reject) => {
          
        const req = http.request(options, (res) => {
          res.setEncoding('utf8');
          res.on('data', (chunk) => {
            console.log(`BODY: ${chunk}`);
          });
          res.on('end', () => {
            console.log('No more data in response.');
          });
        });
        
        req.on('error', (e) => {
          console.error(`problem with request: ${e.message}`);
        });
        
        // Write data to request body
        req.write(postData);
        req.end();
       });
       return response;
		
    } catch (err) {
        console.error(err);
        return {
            statusCode: 500,
            body: JSON.stringify({ error: err.message })
        };
    }
};