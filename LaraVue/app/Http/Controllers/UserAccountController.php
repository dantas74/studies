<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Response;
use Inertia\ResponseFactory;

class UserAccountController extends Controller
{
    public function store(Request $request): RedirectResponse
    {
//        $user = User::make(
//            $request->validate([
//                'name' => 'required|string',
//                'email' => 'required|email|unique:users',
//                'password' => 'required|min:8|confirmed'
//            ])
//        );

//        $user->password = Hash::make($user->password);
//        $user->save();

        $user = User::create(
            $request->validate([
                'name' => 'required|string',
                'email' => 'required|email|unique:users',
                'password' => 'required|min:8|confirmed'
            ])
        );

        Auth::login($user);

        return redirect()->route('listing.index')->with('success', 'Account was created');
    }

    public function create(): Response|ResponseFactory
    {
        return inertia('UserAccount/Create');
    }
}
