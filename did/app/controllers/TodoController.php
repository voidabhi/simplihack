<?php 

class TodoController extends \SlimController\SlimController
{
    public function index($id)
    {
                try{
		 $todo = Todo::find($id); 
		 $this->app->response->setBody($todo);
                }catch(Exception $e){
                    $this->app->response->setBody($e->getMessage());
                }
    }
	
    public function all()
    {
                try{
		$todos= Todo::all(); 
		$this->app->response->setBody($todos);
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
              // $app->notFound();
			  $app->log->debug("Todo add");
    }
}
