
<?php

class Student extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    protected $table = 'student';
    protected $fillable = array('username','password','name');
}