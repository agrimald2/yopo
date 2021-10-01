<?php

namespace App\Http\Controllers;

use App\ProductOption;
use App\ProductQuestion;
use Illuminate\Http\Request;

class ProductQuestionController extends Controller
{
    public function addQuestion(Request $request)
    {
        $validated = $request->validate([
            'product_id' => 'required|numeric',
            'question' => 'required|string'
        ]);

        return ProductQuestion::create($validated)->load('options');
    }


    public function addOption(Request $request)
    {
        $request->validate([
            'question_id' => 'required|numeric',
            'option' => 'required|array',
            'option.option' => 'required|string',
            'option.price' => 'required|numeric',
        ]);

        $question = ProductQuestion::findOrFail($request->question_id);

        return $question->options()->create($request->option);
    }

    public function removeQuestion(Request $request)
    {
        $request->validate([
            'id' => 'required|numeric',
        ]);

        $question = ProductQuestion::findOrFail($request->id);

        $question->options->each->delete();

        return $question->delete();
    }

    public function removeOption(Request $request)
    {
        $request->validate([
            'id' => 'required|numeric',
        ]);

        return ProductOption::findOrFail($request->id)->delete();
    }
}
