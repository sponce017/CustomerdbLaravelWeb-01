<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CbCurrency;

class CbCurrencyController extends Controller
{
    public function index()
    {
        $monedas = CbCurrency::get();
        return view('monedas.index')->with('monedas',$monedas);
    }

    public function show($IdCurrency)
    {
        $moneda = CbCurrency::find($IdCurrency);
        return view('monedas.show')->with('moneda',$moneda);
    }
}
