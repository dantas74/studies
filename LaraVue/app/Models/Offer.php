<?php

namespace App\Models;

use Auth;
use Eloquent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Carbon;

/**
 * App\Models\Offer
 *
 * @property int $id
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @property int $listing_id
 * @property int $bidder_id
 * @property int $amount
 * @property string|null $accepted_at
 * @property string|null $rejected_at
 * @property-read User $bidder
 * @property-read Listing $listing
 * @method static Builder|Offer byMe()
 * @method static Builder|Offer newModelQuery()
 * @method static Builder|Offer newQuery()
 * @method static Builder|Offer query()
 * @method static Builder|Offer whereAcceptedAt($value)
 * @method static Builder|Offer whereAmount($value)
 * @method static Builder|Offer whereBidderId($value)
 * @method static Builder|Offer whereCreatedAt($value)
 * @method static Builder|Offer whereId($value)
 * @method static Builder|Offer whereListingId($value)
 * @method static Builder|Offer whereRejectedAt($value)
 * @method static Builder|Offer whereUpdatedAt($value)
 * @mixin Eloquent
 */
class Offer extends Model
{
    use HasFactory;

    protected $fillable = ['amount', 'accepted_at', 'rejected_at'];

    public function listing(): BelongsTo
    {
        return $this->belongsTo(Listing::class, 'listing_id');
    }

    public function bidder(): BelongsTo
    {
        return $this->belongsTo(User::class, 'bidder_id');
    }

    public function scopeByMe(Builder $query): Builder
    {
        return $query->where('bidder_id', Auth::user()?->id);
    }

    public function scopeExcept(Builder $query, Offer $offer): Builder
    {
        return $query->where('id', '!=', $offer->id);
    }
}
