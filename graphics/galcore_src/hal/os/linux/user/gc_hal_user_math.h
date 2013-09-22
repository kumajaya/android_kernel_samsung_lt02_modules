/****************************************************************************
*
*    Copyright (c) 2005 - 2012 by Vivante Corp.
*    
*    This program is free software; you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation; either version 2 of the license, or
*    (at your option) any later version.
*    
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
*    GNU General Public License for more details.
*    
*    You should have received a copy of the GNU General Public License
*    along with this program; if not write to the Free Software
*    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*
*
*****************************************************************************/



#ifndef __gc_hal_user_math_h_
#define __gc_hal_user_math_h_

#define _ISOC99_SOURCE

#include <math.h>

#define gcoMATH_ModuloInt(X, Y)  (gctINT)((X) % (Y))
#define gcoMATH_ModuloUInt(X, Y) (gctUINT)((X) % (Y))
#define gcoMATH_Modulo(X, Y)     (gctFLOAT)(fmodf((X),(Y)))


#define gcoMATH_Sine(X)       (gctFLOAT)(sinf((X)))
#define gcoMATH_Cosine(X)     (gctFLOAT)(cosf((X)))
#define gcoMATH_Floor(X)      (gctFLOAT)(floorf((X)))
#define gcoMATH_Ceiling(X)    (gctFLOAT)(ceilf((X)))
#define gcoMATH_Exp(X)        (gctFLOAT)(expf((X)))
#define gcoMATH_Exp2(X)        (gctFLOAT)(powf(2.0f, (X)))
#define gcoMATH_Absolute(X)   (gctFLOAT)(fabsf((X)))
#define gcoMATH_ArcCosine(X)  (gctFLOAT)(acosf((X)))
#define gcoMATH_Tangent(X)    (gctFLOAT)(tanf((X)))
#define gcoMATH_ArcSine(X)    (gctFLOAT)(asinf((X)))
#define gcoMATH_ArcTangent(X) (gctFLOAT)(atanf((X)))

#define gcoMATH_Log(X)        (gctFLOAT)(logf((X)))
#define gcoMATH_Log2(X)        (gctFLOAT)(logf((X)) / logf(2.0f))

#define gcoMATH_SquareRoot(X) (gctFLOAT)(sqrtf((X)))
#define gcoMATH_ReciprocalSquareRoot(X) (gctFLOAT)(1.0f / sqrtf((X)))

#define gcoMATH_DivideInt(X, Y)    (gctINT)((X) / (Y))
#define gcoMATH_DivideUInt(X, Y)   (gctUINT)((X) / (Y))
#define gcoMATH_DivideUInt64(X, Y) (gctUINT64)((X) / (Y))
#define gcoMATH_Add(X, Y)          (gctFLOAT)((X) + (Y))
#define gcoMATH_Multiply(X, Y)     (gctFLOAT)((X) * (Y))
#define gcoMATH_Divide(X, Y)       (gctFLOAT)((X) / (Y))
#define gcoMATH_Power(X, Y)        (gctFLOAT)(powf((X),(Y)))
#define gcoMATH_DivideFromUInteger(X, Y) (gctFLOAT)(X) / (gctFLOAT)(Y)

#define gcoMATH_UInt2Float(X)  (gctFLOAT)(X)
#define gcoMATH_Int2Float(X)   (gctFLOAT)(X)
#define gcoMATH_Float2UInt(X)  (gctUINT) (X)
#define gcoMATH_Float2Int(X)   (gctINT)  (X)
#define gcoMATH_Float2Int64(X) (gctINT64)  (X)
#define gcoMATH_Fixed2Float(X) (gctFLOAT)((X) / 65536.0f)
#define gcoMATH_Float2NormalizedUInt8(X) (gctUINT8)((X) * 255.0f)

#define gcoMATH_MultiplyFixed(X, Y) \
    (gctFIXED_POINT)( ((gctINT64) (X) * (Y)) >> 16 )

#define gcoMATH_DivideFixed(X, Y) \
    (gctFIXED_POINT)( (((gctINT64) (X)) << 16) / (Y) )

#define gcoMATH_MultiplyDivideFixed(X, Y, Z) \
    (gctFIXED_POINT)( (gctINT64) (X) * (Y) / (Z) )

#define gcoMATH_FloatRound2UInt(X)  (gctUINT) (X + 0.5)

#endif

