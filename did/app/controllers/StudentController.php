<?php 

class StudentController extends \SlimController\SlimController
{
    public function index($id)
    {
                try{
		 $teacher = Student::find($id); 
		 $this->app->response->setBody($teacher);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }
	
	public function username($username)
	{
                try{
				 $teacher = Student::where('username', '=', $username)->first();
				 $this->app->response->setBody($teacher);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }		
	}
	
    public function all()
    {
                try{
				$teachers= Student::all(); 
				$this->app->response->setBody($teachers);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }	
    
    public function addStudent()
    {
				$this->app->response->setBody("Adding Student");
				/*print("Add student called");
                try{
                $todoParams = $this->app->request->params();
                $response='';
                if(isset($todoParams['username'],$todoParams['password'],$todoParams['name']))
                {
                    Student::create(array(
                                'username'=>$todoParams['username'],
								'password'=>$todoParams['password'],
								'name'=>$todoParams['name']
                            ));
                   $response = '{"message":"Student Created"}';
                }
                else {
                    $response = '{"message":"Student Not Created"}';
                }
                $this->app->response->setBody($response);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
               $app->notFound();*/
    }
}
