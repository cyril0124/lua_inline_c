#!/usr/bin/env luajit

local c = require 'ffi-c.c'
local cpp = require 'ffi-c.cpp'
local ffi = require 'ffi'

-- 
-- example_1: simple function
-- 
local sum = c:func('int sum(int a, int b)', 'return a + b;')
print(sum.lib.sum(2,3))
local mul = cpp:func('int mul(int a, int b)', 'return a * b;')
print(mul.lib.mul(2,3))


-- 
-- example_2: martix multiplication
-- 
local matrix_mul_code = c:func('void matrix_mul(float* A, float* B, float* C, int M, int N, int K)',
[[
  //printf("hhh\n");
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < K; j++) {
            C[i * K + j] = 0;
            for (int k = 0; k < N; k++) {
                C[i * K + j] += A[i * N + k] * B[k * K + j];
            }
        }
    }
]]
)

local M, N, K = 10, 6, 4

local A = ffi.new("float[?]", M * N)
local B = ffi.new("float[?]", N * K)
local C = ffi.new("float[?]", M * K)

for i = 0, (M * N) - 1 do
    A[i] = math.random(1, 1000)
end

for i = 0, (N * K) - 1 do
    B[i] = math.random(1, 1000)
end

local lib = matrix_mul_code.lib
lib.matrix_mul(A, B, C, M, N, K)

for i = 0, M-1 do
    for j = 0, K-1 do
        io.write(string.format("%8.1f\t", C[i * K + j]))
    end
    io.write("\n")
end
