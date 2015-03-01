
<?php

class Course extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    protected $table = 'course';
    protected $fillable = array('title','energy');
}