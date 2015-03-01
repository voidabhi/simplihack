
<?php

class Teacher extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    protected $table = 'teacher';
    protected $fillable = array('username','password','name');
}