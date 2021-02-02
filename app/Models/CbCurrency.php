<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CbCurrency extends Model
{
    protected $table = 'cb_currency';

    protected $primaryKey = 'idcurrency';

    protected $fillable = array('currency', 'description', 'isactive', 'isocode', 'cursymbol', 'precisionstd', 'precisioncost','precisionprize');

    protected $hidden = ['created_at', 'updated_at'];
}
