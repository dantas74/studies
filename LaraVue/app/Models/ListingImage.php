<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * App\Models\ListingImage
 *
 * @property int $id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property string $filename
 * @property int $listing_id
 * @property-read string $src
 * @property-read \App\Models\Listing $listing
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage query()
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage whereFilename($value)
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage whereListingId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|ListingImage whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class ListingImage extends Model
{
    use HasFactory;

    protected $fillable = ['filename'];
    protected $appends = ['src'];

    public function listing(): BelongsTo
    {
        return $this->belongsTo(Listing::class);
    }

    public function getSrcAttribute(): string
    {
        return asset("storage/{$this->filename}");
    }
}
