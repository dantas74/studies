<?php

namespace App\Http\Controllers;

class IndexController extends Controller
{
    public function index()
    {
        return inertia('Index/Index', [
            'message' => 'Hello from Laravel! (Index page)'
        ]);
    }

    public function show()
    {
        return inertia('Index/Show', [
            'message' => 'Hello from Laravel! (Show page)'
        ]);
    }
}
