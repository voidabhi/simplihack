<?php 

class TeacherController extends \SlimController\SlimController
{
    public function index($id)
    {
                try{
		 $teacher = Teacher::find($id); 
		 $this->app->response->setBody($teacher);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }
	
	public function username($username)
	{
                try{
				 $teacher = Teacher::where('username', '=', $username)->first();
				 $this->app->response->setBody($teacher);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }		
	}
	
    public function all()
    {
                try{
				$teachers= Teacher::all(); 
				$this->app->response->setBody($teachers);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }	
    
    public function addTodo()
    {
               /* try{
                $todoParams = $this->app->request->params();
                $response='';
                if($todoParams['title'])
                {
                    Todo::create(array(
                                'title'=>$todoParams['title']
                            ));
                   $response = '{"message":"Todo Created"}';
                }
                else {
                    $response = '{"message":"Todo Not Created"}';
                }
                $this->app->response->setBody($response);
                                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }*/
               $app->notFound();
    }
}
