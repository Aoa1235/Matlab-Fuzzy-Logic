
classdef Triangle

    properties
        incriment = double(0.05);    %incriment at which triangle increases at (same for all triangles
        lenOfMax = 1;                %number of values that are max (set to 1 for triangle)
        maxVal = 1;                  %max value (between 0 and 1)
        
        midXVal = 0;                 %middle x value that triangle centers at
        startXVal = -5;              %Start x value that triangle starts at
        finalXVal = 5;               %final x value that triangle ends at
        
        portionOfInterest = 1;         %Area in particular triangle
        
        color = "black";             %colors of each triangle

        xrange;                      %range of xVals on graph
        triangleRange;               %range of yVals on graph

        arrayOfInterest;             %shaded part under Value of Interest
    end

    methods

        function Triangle = Triangle(varargin)

            %Instantiates default values

            p = inputParser();

            addParameter(p, 'incriment', Triangle.incriment);
            addParameter(p, 'lenOfMax', Triangle.lenOfMax);
            addParameter(p, 'maxVal', Triangle.maxVal);

            addParameter(p, 'midXVal', Triangle.midXVal);
            addParameter(p, 'startXVal', Triangle.startXVal);
            addParameter(p, 'finalXVal', Triangle.finalXVal);

            addParameter(p, 'portionOfInterest', Triangle.portionOfInterest);

            addParameter(p, 'color', Triangle.color);

            parse(p, varargin{:})

            Triangle.incriment = p.Results.incriment;
            Triangle.lenOfMax = p.Results.lenOfMax;
            Triangle.maxVal = p.Results.maxVal;
            
            Triangle.midXVal = p.Results.midXVal;
            Triangle.startXVal = p.Results.startXVal;
            Triangle.finalXVal = p.Results.finalXVal;
            
            Triangle.portionOfInterest = p.Results.portionOfInterest;
            
            Triangle.color = p.Results.color;
           
            %For default Inputs
           
            [Triangle.xrange, Triangle.triangleRange] = ...
                Triangle.intializeTriangle(Triangle.startXVal, Triangle.midXVal, ...
                Triangle.finalXVal, Triangle.incriment, Triangle.lenOfMax, Triangle.maxVal);
            
            Triangle.arrayOfInterest = Triangle.ShadedTriangleArray(Triangle.portionOfInterest, Triangle.triangleRange);
        
        end


        function [xrange, triangleRange] = intializeTriangle(Triangle, ...
                startXVal, midXVal, finalXVal, incriment, lenOfMax, maxVal)
    
            %creates a triangle and an approperiate range for it
            
            %increments from 0 to one increment lower than maxVal, 
            %then sets the number of maxvals at the top, 
            %and finally from one less incriment of maxVal, it decriments down back to zero.

            triangleRange = [0:incriment:(maxVal-incriment), maxVal.*ones(1, lenOfMax), (maxVal-incriment):-incriment:0];
            triSize = length(triangleRange);
        
            xIncrimentBefore = (midXVal-startXVal)/(ceil(triSize/2));
            xIncrimentAfter = (finalXVal-midXVal)/(floor(triSize/2));
        
            xrange = [startXVal:xIncrimentBefore:midXVal, ...
                (midXVal+xIncrimentAfter):xIncrimentAfter:finalXVal-xIncrimentAfter];

        end

        function [ArrayOfInterest] = ShadedTriangleArray(Triangle, argVal, argTriangle)
   
            % Shaded region of the triangle is found through the combination of the line at the argVal, 
            % and then taking the triangle values for the sides below it.
        
            ArrayOfInterest = argVal.*(argTriangle >= argVal) + argTriangle.*(not(argTriangle >= argVal));
        end

    end

end