<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Response;
use Inertia\ResponseFactory;

class AuthController extends Controller
{
    public function create(): Response|ResponseFactory
    {
        return inertia('Auth/Login');
    }

    public function store(Request $request)
    {
        Auth::attempt(
            $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string'
            ]),
            true
        );
    }

    public function destroy()
    {

    }
}
