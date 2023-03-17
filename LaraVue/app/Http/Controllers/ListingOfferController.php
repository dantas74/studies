<?php

namespace App\Http\Controllers;

use App\Models\Listing;
use App\Models\Offer;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;

class ListingOfferController extends Controller
{
    /**
     * @throws AuthorizationException
     */
    public function store(Listing $listing, Request $request): RedirectResponse
    {
        $this->authorize('view', $listing);

        $listing->offers()->save(
            Offer::make(
                $request->validate([
                    'amount' => 'required|integer|min:1|max:200000000'
                ])
            )->bidder()->associate($request->user())
        );

        return redirect()->back()->with('success', 'Offer was made!');
    }
}
