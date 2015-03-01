<?php

class OAuth2Auth extends \Slim\Middleware
{
    protected $headers = array();
	
    public function __construct($headers) {
        $this->headers = $headers;
    }

    public function call() {
        // no auth header
		if(!isset($this->headers['Authorization'])) {
			$this->app->response->setBody("Access credentials not supplied");
        } 
		else {
			 $this->next->call();
           }
		   
        // this line is required for the application to proceed
       $this->next->call();
    }
}