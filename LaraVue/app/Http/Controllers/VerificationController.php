<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Response;
use Inertia\ResponseFactory;

class VerificationController extends Controller
{
    public function notice(): Response|ResponseFactory
    {
        return inertia('Auth/VerifyEmail');
    }

    public function verify(EmailVerificationRequest $request): RedirectResponse
    {
        $request->fulfill();

        return redirect()->route('listing.index')->with('success', 'Email was verified');
    }

    public function send(Request $request): RedirectResponse
    {
        $request->user()->sendEmailVerificationNotification();

        return redirect()->back()->with('success', 'Verification link sent!');
    }
}
