<?php

class Todo extends Illuminate\Database\Eloquent\Model {
    public $timestamps = false;
    protected $table = 'todo';
    protected $fillable = array('title');
}