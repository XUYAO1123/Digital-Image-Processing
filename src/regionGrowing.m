% 区域生长函数
function region = regionGrowing(~, I, seed, threshold)
    [rows, cols] = size(I);
    region = false(rows, cols);
    region(seed(1), seed(2)) = true;
    while true
        newRegion = region;
        for r = 1:rows
            for c = 1:cols
                if region(r, c)
                    for dr = -1:1
                        for dc = -1:1
                            rr = r + dr;
                            cc = c + dc;
                            if rr > 0 && rr <= rows && cc > 0 && cc <= cols && ~region(rr, cc)
                                if abs(I(rr, cc) - I(r, c)) < threshold
                                    newRegion(rr, cc) = true;
                                end
                            end
                        end
                    end
                end
            end
        end
        if isequal(newRegion, region)
            break;
        end
        region = newRegion;
    end
end
